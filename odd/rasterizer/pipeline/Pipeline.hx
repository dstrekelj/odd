package odd.rasterizer.pipeline;

import haxe.ds.Vector;

import odd.data.DepthBuffer;
import odd.math.Mat4x4;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.pipeline.PrimitiveAssembler;
import odd.rasterizer.pipeline.ScanConverter;
import odd.rasterizer.pipeline.VertexPostProcessor;
import odd.rasterizer.pipeline.VertexProcessor;
import odd.rasterizer.Scene;
import odd.Framebuffer;

/**
 * Rasterisation pipeline.
 * 
 * TODO: Define a scene type to serve as a container of meshes,
 * avoiding the need for an `addMesh()` method. Also makes it
 * easy to render different mesh groups and configurations.
 */
class Pipeline
{
    var scene : Scene;
    var shader : Shader;

    var transformViewport : Mat4x4;
    
    var depthBuffer : DepthBuffer;

    public function new(viewportWidth : Int, viewportHeight : Int) : Void
    {
        scene = null;
        shader = null;

        // Negative Y.y component to mirror image vertically
        transformViewport = new Mat4x4(
            viewportWidth / 2,   0,                     0,  0,
            0,                  -viewportHeight / 2,    0,  0,
            0,                   0,                     1,  0,
            viewportWidth / 2,   viewportHeight / 2,    0,  1
        );
        
        depthBuffer = new DepthBuffer(viewportWidth, viewportHeight);
    }

    public function setScene(scene : Scene) : Void
    {
        this.scene = scene;
    }

    public function setShader(shader : Shader) : Void
    {
        this.shader = shader;
    }
    
    public function execute(framebuffer : Framebuffer) : Void
    {
        if (shader == null || scene == null) return;

        depthBuffer.clear();

        var primitiveIndices = new Vector<Int>(3);
        // Maximum number of vertices after clipping is 9, so 6 triangle primitives
        var primitives = new Vector<Primitive>(6);

        for (mesh in scene.meshes)
        {
            shader.transformModel = mesh.transform;
            shader.transformView = scene.camera.transformView;
            shader.transformProjection = scene.camera.transformProjection;
            
            var i = 0;
            while (i < mesh.geometry.indices.length)
            {   
                primitiveIndices[0] = mesh.geometry.indices[i];
                primitiveIndices[1] = mesh.geometry.indices[i + 1];
                primitiveIndices[2] = mesh.geometry.indices[i + 2];
        
                // Primitive assembly
                trace("Primitive assembly");
                primitives[0] = PrimitiveAssembler.assembleTriangle(primitiveIndices, mesh.geometry);
                for (p in 1...6) {
                    primitives[p] = null;
                }

                // Vertex processing
                trace("Vertex processing");
                VertexProcessor.process(primitives, shader);
  
                // Vertex post-processing
                trace("Vertex post-processing");
                VertexPostProcessor.process(primitives, transformViewport);

                // Scan conversion
                trace("Scan conversion");
                for (primitive in primitives)
                {
                    if (primitive != null)
                    {
                        ScanConverter.process(framebuffer, depthBuffer, shader, primitive);
                    }
                }

                /*switch (primitive)
                {
                    case Primitive.Triangle(a, b, c):
                        // Vertex processing
                        a = VertexProcessor.process(a, shader);
                        b = VertexProcessor.process(b, shader);
                        c = VertexProcessor.process(c, shader);
                        primitives[0] = Primitive.Triangle(a, b, c);
                        
                        // Vertex post-processing                        
                        a = VertexPostProcessor.process(a, transformViewport);
                        b = VertexPostProcessor.process(b, transformViewport);
                        c = VertexPostProcessor.process(c, transformViewport);
                        primitive = Primitive.Triangle(a, b, c);
                        
                        // Scan conversion                        
                        ScanConverter.process(framebuffer, depthBuffer, shader, primitive);
                    case _:
                        return;
                }*/
                
                i += 3;
            }
        }
    }
}