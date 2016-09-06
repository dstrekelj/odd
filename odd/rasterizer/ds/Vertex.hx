package odd.rasterizer.ds;

import odd.math.Vec4;
import odd.math.Vec3;
import odd.math.Vec2;

class Vertex
{
    public var position : Vec4;
    public var color : Vec3;
    public var normal : Vec3;
    public var textureCoordinate : Vec2; 
    
    public function new() : Void
    {
        position = null;
        color = null;
        normal = null;
        textureCoordinate = null;
    }

    public function lerp(to : Vertex) : Void
    {
        lerpVec4(position, to.position, position.w, to.position.w);
        if (color != null) lerpVec3(color, to.color, position.w, to.position.w);
        if (normal != null) lerpVec3(normal, to.normal, position.w, to.position.w);
        if (textureCoordinate != null) lerpVec2(textureCoordinate, to.textureCoordinate, position.w, to.position.w);
    }

    public function lerpVec2(from : Vec2, to : Vec2, fromW : Float, toW : Float) : Void
    {
        var factorX = (fromW - from.x) / (fromW - from.x - toW + to.x);
        var factorY = (fromW - from.y) / (fromW - from.y - toW + to.y);
        from = from.lerp(to, factorX) + from.lerp(to, factorY);
    }

    public function lerpVec3(from : Vec3, to : Vec3, fromW : Float, toW : Float) : Void
    {
        var factorX = (fromW - from.x) / (fromW - from.x - toW + to.x);
        var factorY = (fromW - from.y) / (fromW - from.y - toW + to.y);
        var factorZ = (fromW - from.z) / (fromW - from.z - toW + to.z);
    }

    public function lerpVec4(from : Vec4, to : Vec4, fromW : Float, toW : Float) : Void
    {
        var factorX = (fromW - from.x) / (fromW - from.x - toW + to.x);
        var factorY = (fromW - from.y) / (fromW - from.y - toW + to.y);
        var factorZ = (fromW - from.z) / (fromW - from.z - toW + to.z);
        var factorW = (fromW - from.w) / (fromW - from.w - toW + to.w); 
    }
}