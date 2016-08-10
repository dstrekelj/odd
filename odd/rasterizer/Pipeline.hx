package odd.rasterizer;

import odd.Framebuffer;
import odd.data.DepthBuffer;
import odd.geom.Mesh;
import odd.math.Mat4x4;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.stages.PrimitiveAssembler;
import odd.rasterizer.stages.ScanConverter;
import odd.rasterizer.stages.VertexPostProcessor;
import odd.rasterizer.stages.VertexProcessor;

/**
 * Rasterisation pipeline.
 * 
 * TODO: Define a scene type to serve as a container of meshes,
 * avoiding the need for an `addMesh()` method. Also makes it
 * easy to render different mesh groups and configurations.
 */
class Pipeline
{
    public var shader : Shader;
    
    private var meshes : Array<Mesh>;
    private var transformView : Mat4x4;
    private var transformProjection : Mat4x4;
    private var transformViewport : Mat4x4;
    
    private var depthBuffer : DepthBuffer;
    private var clearedDepthBuffer : DepthBuffer;
    
    public function new(viewportWidth : Int, viewportHeight : Int)
    {
        shader = new Shader();
        
        meshes = new Array<Mesh>();
        // TODO: Define a proper camera type.
        transformView = Mat4x4.translate(0, 0, -4);
        transformProjection = Mat4x4.perspective(100, 4 / 3, 1, 100);
        // Negative Y.y component to mirror image vertically
        transformViewport = new Mat4x4(
            viewportWidth / 2,   0,                     0,  0,
            0,                  -viewportHeight / 2,    0,  0,
            0,                   0,                     1,  0,
            viewportWidth / 2,   viewportHeight / 2,    0,  1
        );
        
        depthBuffer = new DepthBuffer(viewportWidth, viewportHeight);
        clearedDepthBuffer = new DepthBuffer(viewportWidth, viewportHeight);
    }
    
    public function addMesh(mesh : Mesh) : Void
    {
        meshes.push(mesh);
    }
    
    public function execute(framebuffer : Framebuffer) : Void
    {
        depthBuffer.blit(0, clearedDepthBuffer.bytes, 0, depthBuffer.width * depthBuffer.height * 8);
        
        for (mesh in meshes)
        {
            shader.transformModel = mesh.transform;
            shader.transformView = transformView;
            
            var indices = mesh.geometry.indices;
            
            var i = 0;
            while (i < indices.length)
            {
                var primitiveIndices = [indices[i], indices[i + 1], indices[i + 2]];
                
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
                        a = VertexPostProcessor.process(a, transformProjection, transformViewport);
                        b = VertexPostProcessor.process(b, transformProjection, transformViewport);
                        c = VertexPostProcessor.process(c, transformProjection, transformViewport);
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