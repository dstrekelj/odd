package odd.rasterizer.stages;

import odd.math.Mat4x4;
import odd.math.Vec4;
import odd.rasterizer.ds.Vertex;
import odd.rasterizer.ds.VertexAttribute;

/**
 * Handles vertex post-processing (projection, clipping, ...).
 */
class VertexPostProcessor
{
    public static function process(vertex : Vertex, transformProjection : Mat4x4, transformViewport : Mat4x4) : Vertex
    {
        var processedVertex : Vertex = [];
        
        for (attribute in vertex)
        {
            switch (attribute)
            {
                case VertexAttribute.Position(x, y, z, w):
                    var p = new Vec4(x, y, z, w);
                    //trace("1. RAW...", p);
                    p *= transformProjection;
                    //trace("2. PROJECTION...", p);
                    if (clip(p))
                    {
                        // TODO: Clipping.
                        trace("This should be discarded by clipping!");
                    }
                    p /= p.w;
                    //trace("3. DIVISION...", p);
                    p *= transformViewport;
                    //trace("4. VIEWPORT...", p);
                    processedVertex.push(VertexAttribute.Position(p.x, p.y, p.z, p.w));
                case _:
                    processedVertex.push(attribute);
            }
        }
        
        return processedVertex;
    }
    
    private static function clip(p : Vec4) : Bool
    {
        if (p.x < -p.w || p.x > p.w) return true;
        if (p.y < -p.w || p.y > p.w) return true;
        if (p.z < -p.w || p.z > p.w) return true;
        return false;
    }
}