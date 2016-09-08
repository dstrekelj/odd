package odd.rasterizer.pipeline;

import haxe.ds.Vector;

import odd.data.DepthBuffer;
import odd.math.Mat4x4;
import odd.rasterizer.ds.primitives.Triangle;
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
        var tris = 0;

        if (shader == null || scene == null) return;

        depthBuffer.clear();

        var triangleIndices = new Vector<Int>(3);

        for (mesh in scene.meshes)
        {
            shader.transformModel = mesh.transform;
            shader.transformView = scene.camera.transformView;
            shader.transformProjection = scene.camera.transformProjection;
            shader.texture = mesh.texture;
            
            var i = 0;
            while (i < mesh.geometry.indices.length)
            {   
                triangleIndices[0] = mesh.geometry.indices[i];
                triangleIndices[1] = mesh.geometry.indices[i + 1];
                triangleIndices[2] = mesh.geometry.indices[i + 2];
        
                // Primitive assembly
                var triangle = PrimitiveAssembler.assembleTriangle(triangleIndices, mesh.geometry);

                // Vertex processing
                VertexProcessor.process(triangle, shader);

                // Vertex post-processing
                VertexPostProcessor.process(triangle, transformViewport);

                if (triangle.isValid)
                {
                    // Scan conversion
                    ScanConverter.process(framebuffer, depthBuffer, shader, triangle);
                    tris++;
                }

                i += 3;
            }
        }
        
        trace("drew " + tris + " tris");
    }
}