package odd.rasterizer;

import odd.data.DepthBuffer;
import odd.math.Mat4x4;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.object.Camera;
import odd.rasterizer.object.Mesh;
import odd.rasterizer.object.Scene;
import odd.rasterizer.stages.PrimitiveAssembler;
import odd.rasterizer.stages.ScanConverter;
import odd.rasterizer.stages.VertexPostProcessor;
import odd.rasterizer.stages.VertexProcessor;
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
        shader = new Shader();
        scene = new Scene();

        //transformProjection = Mat4x4.perspective(100, 4 / 3, 1, 100);

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
        if (scene == null) return;

        depthBuffer.clear();
        
        for (mesh in scene.meshes)
        {
            shader.transformModel = mesh.transform;
            shader.transformView = scene.camera.transformView;
            shader.transformProjection = scene.camera.transformProjection;
            
            var i = 0;
            while (i < mesh.geometry.indices.length)
            {
                var primitiveIndices = [
                    mesh.geometry.indices[i],
                    mesh.geometry.indices[i + 1],
                    mesh.geometry.indices[i + 2]
                ];
                
                // Primitive assembly
                var primitive = PrimitiveAssembler.assembleTriangle(primitiveIndices, mesh.geometry);
                //trace("1. PRIMITIVE ASSEMBLY...", primitive);
                
                switch (primitive)
                {
                    case Primitive.Triangle(a, b, c):
                        // Vertex processing
                        //trace("2. VERTEX PROCESSING...");
                        
                        a = VertexProcessor.process(a, shader);
                        b = VertexProcessor.process(b, shader);
                        c = VertexProcessor.process(c, shader);
                        primitive = Primitive.Triangle(a, b, c);
                        
                        //trace(primitive);
                        // Vertex post-processing
                        //trace("3. VERTEX POST-PROCESSING...");
                        
                        a = VertexPostProcessor.process(a, transformViewport);
                        b = VertexPostProcessor.process(b, transformViewport);
                        c = VertexPostProcessor.process(c, transformViewport);
                        primitive = Primitive.Triangle(a, b, c);
                        
                        //trace(primitive);
                        // Scan conversion
                        //trace("4. SCAN CONVERSION...");
                        
                        ScanConverter.process(framebuffer, depthBuffer, shader, primitive);
                    case _:
                        return;
                }
                
                i += 3;
            }
        }
    }
}