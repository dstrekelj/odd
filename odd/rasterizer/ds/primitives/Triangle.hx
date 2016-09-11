package odd.rasterizer.ds.primitives;

import odd.math.Vec3;

class Triangle
{
    public var a : Vertex;
    public var b : Vertex;
    public var c : Vertex;

    public var faceNormal : Vec3;

    @:allow(odd.rasterizer.pipeline)
    public var isValid(default, null) : Bool;

    public function new(a : Vertex, b : Vertex, c : Vertex) : Void
    {
        this.a = a;
        this.b = b;
        this.c = c;

        isValid = true;

        calculateFaceNormal();
    }

    public function calculateFaceNormal() : Vec3
    {
        var ab : Vec3 = (b.position - a.position);
        var ac : Vec3 = (c.position - a.position);
        ab.normalize();
        ac.normalize();
        faceNormal = ab.cross(ac);
        return faceNormal;
    }

    public function hasColorAttribute() : Bool
    {
        return a.color != null && b.color != null && c.color != null;
    }

    public function hasNormalAttribute() : Bool
    {
        return a.normal != null && b.normal != null && c.normal != null;
    }

    public function hasTextureCoordinateAttribute() : Bool
    {
        return a.textureCoordinate != null && b.textureCoordinate != null && c.textureCoordinate != null;
    }
}