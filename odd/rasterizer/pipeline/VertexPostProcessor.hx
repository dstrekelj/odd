package odd.rasterizer.pipeline;

import odd.math.Mat4x4;
import odd.math.Vec4;
import odd.rasterizer.ds.primitives.Triangle;

/**
 * Handles vertex post-processing (projection, clipping, ...).
 */
class VertexPostProcessor
{
    public static function process(triangle : Triangle, transformViewport : Mat4x4) : Void
    {
        if (triangle.a.position.w < 0 && triangle.b.position.w < 0 && triangle.c.position.w < 0)
        {
            //trace("...Triangle culled. Vertex w < 0.");
            triangle.isValid = false;
            return;
        }

        var aClipState = getClipState(triangle.a.position);
        var bClipState = getClipState(triangle.b.position);
        var cClipState = getClipState(triangle.c.position);

        //trace("...Clip state: ", aClipState, bClipState, cClipState);

        if ((aClipState & bClipState & cClipState) != ClipState.INSIDE)
        {
            //trace("...Triangle culled. Vertices outside frustum.");
            triangle.isValid = false;
            return;
        }

        //trace("...Perspective divide");
        triangle.a.perspectiveDivide();
        triangle.b.perspectiveDivide();
        triangle.c.perspectiveDivide();
        //trace("...Calculate face normal");
        triangle.calculateFaceNormal();

        //trace(Std.string(triangle));

        if (triangle.faceNormal.z <= 0)
        {
            //trace("...Triangle culled. Face normal not facing camera.");
            triangle.isValid = false;
            return;
        }

        //trace("...Viewport transform");
        triangle.a.viewportTransform(transformViewport);
        triangle.b.viewportTransform(transformViewport);
        triangle.c.viewportTransform(transformViewport);

        triangle.isValid = true;
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
}