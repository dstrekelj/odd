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

    public static function cube() : Geometry
    {
        var g = new Geometry();

        
        gCube.positions = [
            -1.0,-1.0, 1.0, /**/ 1.0,-1.0, 1.0, /**/ 1.0, 1.0, 1.0, /**/ -1.0, 1.0, 1.0,
            -1.0,-1.0,-1.0, /**/ 1.0,-1.0,-1.0, /**/ 1.0, 1.0,-1.0, /**/ -1.0, 1.0,-1.0
        ];
        gCube.indices = [
            0, 1, 2, /**/ 2, 3, 0,  // +z plane
            1, 5, 6, /**/ 6, 2, 1,  // +x plane
            5, 4, 7, /**/ 7, 6, 5,  // -z plane
            4, 0, 3, /**/ 3, 7, 4,  // -x plane
            0, 4, 5, /**/ 5, 1, 0,  // -y plane
            3, 2, 6, /**/ 6, 7, 3   // +y plane
        ];

        return g;
    }
}