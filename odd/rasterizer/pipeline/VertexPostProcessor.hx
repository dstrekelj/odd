package odd.rasterizer.pipeline;

import haxe.ds.Vector;

import odd.math.Mat4x4;
import odd.math.Vec4;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.ds.Vertex;

/**
 * Handles vertex post-processing (projection, clipping, ...).
 */
class VertexPostProcessor
{
    public static function process(primitives : Vector<Primitive>, transformViewport : Mat4x4) : Void
    {
        switch (primitives[0])
        {
            case Primitive.Line(a, b):
                clipLine(a, b, primitives, transformViewport);
            case Primitive.Point(a):
                clipPoint(a, primitives, transformViewport);
            case Primitive.Triangle(a, b, c):
                clipTriangle(a, b, c, primitives, transformViewport);
        }
    }

    static function clipLine(a : Vertex, b : Vertex, primitives : Vector<Primitive>, transformViewport : Mat4x4) : Void
    {
        var aClipState = getClipState(a.position);
        var bClipState = getClipState(b.position);

        if ((aClipState & bClipState) != ClipState.OUTSIDE)
        {
            transform(a, transformViewport);
            transform(b, transformViewport);
            primitives[0] = Primitive.Line(a, b);
        }
    }

    static function clipPoint(a : Vertex, primitives : Vector<Primitive>, transformViewport : Mat4x4) : Void
    {
        if (getClipState(a.position) == ClipState.INSIDE)
        {
            transform(a, transformViewport);
            primitives[0] = Primitive.Point(a);
        }
    }
    
    static function clipTriangle(a : Vertex, b : Vertex, c : Vertex, primitives : Vector<Primitive>, transformViewport : Mat4x4) : Void
    {
        var aClipState = getClipState(a.position);
        var bClipState = getClipState(b.position);
        var cClipState = getClipState(c.position);
        trace(aClipState, bClipState, cClipState);
        if ((aClipState & bClipState & cClipState) == ClipState.INSIDE)
        {
            trace("inside");
            transform(a, transformViewport);
            transform(b, transformViewport);
            transform(c, transformViewport);
            primitives[0] = Primitive.Triangle(a, b, c);
        }
    }

    static function transform(v : Vertex, transformViewport : Mat4x4) : Void
    {
        v.position /= v.position.w;
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