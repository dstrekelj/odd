package odd.rasterizer.tools;

import odd.rasterizer.object.Geometry;

class PrimitiveGeometry
{
    public static function triangle() : Geometry
    {
        var g = new Geometry();

        g.positions = [
            -1.0, -1.0, 0.0, /**/ 1.0, -1.0, 0.0, /**/ 0.0, 1.0, 0.0     
        ];
        g.indices = [
            0, 1, 2
        ];

        return g;
    }
}