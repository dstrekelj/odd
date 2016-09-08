package odd.rasterizer.tools;

import odd.rasterizer.Geometry;

class PrimitiveGeometry
{
    public static function cube() : Geometry
    {
        var g = new Geometry();
        
        g.positions = [
            -1.0,-1.0, 1.0,
             1.0,-1.0, 1.0,
             1.0, 1.0, 1.0,
            -1.0, 1.0, 1.0,
            -1.0,-1.0,-1.0,
             1.0,-1.0,-1.0,
             1.0, 1.0,-1.0,
            -1.0, 1.0,-1.0
        ];
        g.indices = [
            0, 1, 2, 2, 3, 0,   // Facing +z
            1, 5, 6, 6, 2, 1,   // Facing +x
            5, 4, 7, 7, 6, 5,   // Facing -z
            4, 0, 3, 3, 7, 4,   // Facing -x
            0, 4, 5, 5, 1, 0,   // Facing -y
            3, 2, 6, 6, 7, 3    // Facing +y
        ];

        return g;
    }

    public static function octahedron() : Geometry
    {
        var g = new Geometry();

        g.positions = [
             0.0, 0.0, 1.0,
             1.0, 0.0, 0.0,
             0.0, 0.0,-1.0,
            -1.0, 0.0, 0.0,
             0.0, 1.0, 0.0,
             0.0,-1.0, 0.0
        ];
        g.indices = [
            0, 1, 4,
            1, 2, 4,
            2, 3, 4,
            3, 0, 4,
            0, 5, 1,
            1, 5, 2,
            2, 5, 3,
            3, 5, 0
        ];

        return g;
    }

    public static function plane() : Geometry
    {
        var g = new Geometry();

        g.positions = [
            -1.0,-1.0, 0.0,
             1.0,-1.0, 0.0,
             1.0, 1.0, 0.0,
            -1.0, 1.0, 0.0
        ];
        g.indices = [
            0, 1, 2, 2, 3, 0
        ];
        
        return g;
    }

    public static function pyramid() : Geometry
    {
        var g = new Geometry();

        g.positions = [
            -1.0,-1.0, 1.0,
             1.0,-1.0, 1.0,
             1.0,-1.0,-1.0,
            -1.0,-1.0,-1.0,
             0.0, 1.0, 0.0
        ];
        g.indices = [
            0, 1, 2, 2, 3, 0,   // Pyramid base
            0, 1, 4,            // Facing +z
            1, 2, 4,            // Facing +x
            2, 3, 4,            // Facing -z
            3, 0, 4             // Facing -x
        ];

        return g;
    }

    public static function triangle() : Geometry
    {
        var g = new Geometry();

        g.positions = [
            -1.0,-1.0, 0.0,
             1.0,-1.0, 0.0,
             0.0, 1.0, 0.0     
        ];
        g.indices = [
            0, 1, 2
        ];

        return g;
    }
}