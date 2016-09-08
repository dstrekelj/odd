package odd.rasterizer.pipeline;

import odd.math.Mat4x4;
import odd.math.Vec4;
import odd.rasterizer.ds.primitives.Triangle;
import odd.rasterizer.ds.Vertex;

/**
 * Handles vertex post-processing (projection, clipping, ...).
 */
class VertexPostProcessor
{
    public static function process(triangle : Triangle, transformViewport : Mat4x4) : Void
    {
        var aClipState = getClipState(triangle.a.position);
        var bClipState = getClipState(triangle.b.position);
        var cClipState = getClipState(triangle.c.position);

        if ((aClipState | bClipState | cClipState) == ClipState.INSIDE)
        {
            transformVertex(triangle.a, transformViewport);
            transformVertex(triangle.b, transformViewport);
            transformVertex(triangle.c, transformViewport);
            triangle.calculateFaceNormal();
            
            if (triangle.faceNormal.z < 0) {
                triangle.isValid = true;
            } else {
                triangle.isValid = false;
            }
        }
        else
        {
            triangle.isValid = false;
        }
    }

    static function transformVertex(v : Vertex, transformViewport : Mat4x4) : Void
    {
        if (v.position.w != 0 && v.position.w != 1)
        {
            v.position /= v.position.w;
        }
        v.position *= transformViewport;
    }
    
    static function getClipState(p : Vec4) : Int
    {
        var code = ClipState.INSIDE;
        if (p.x < -p.w) code = code | ClipState.X_NEG;
        if (p.x >  p.w) code = code | ClipState.X_POS;
        if (p.y < -p.w) code = code | ClipState.Y_NEG;
        if (p.y >  p.w) code = code | ClipState.Y_POS;
        if (p.z < -p.w) code = code | ClipState.Z_NEG;
        if (p.z >  p.w) code = code | ClipState.Z_POS;
        return code;
    }
}

@:enum
abstract ClipState(Int) from Int to Int
{
    var INSIDE = 0;
    var X_POS = 1;
    var X_NEG = 2;
    var Y_POS = 4;
    var Y_NEG = 8;
    var Z_POS = 16;
    var Z_NEG = 32;
    var OUTSIDE = 63;
}