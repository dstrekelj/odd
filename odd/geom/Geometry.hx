package odd.geom;

import odd.math.Vec3;
import odd.render.RenderMethod;
import odd.util.color.RGB;

class Geometry
{
    public var positions : Array<Vec3>;
    public var colors : Array<RGB>;
    public var indices : Array<Int>;
    
    public function new()
    {
        positions = new Array<Vec3>();
        colors = new Array<RGB>();
        indices = new Array<Int>();
    }
    
    public inline function positionsFromArray(array : Array<Float>) : Void
    {   
        var i : Int = 0;
        do {
            positions.push(Vec3.fromArray(array.slice(i, i + 3)));
        } while ((i += 3) < array.length);
    }
    
    public inline function colorsFromArrayInt(array : Array<Int>) : Void
    {
        var i : Int = 0;
        do {
            colors.push(RGB.RGBh(array[i]));
        } while (i++ < array.length);
    }
    
    public inline function colorsFromArrayFloat(array : Array<Float>) : Void
    {
        var i : Int = 0;
        do {
            colors.push(RGB.RGBf(array[i], array[i + 1], array[i + 2]));
        } while ((i += 3) < array.length);
    }
    
    public inline function clone() : Geometry
    {
        var g = new Geometry();
        g.positions = this.positions.copy();
        g.colors = this.colors.copy();
        g.indices = this.indices.copy();
        return g;
    }
    
    @:allow(odd.macro.LoaderMacros)
    public static inline function fromGeometryData(positions : Array<Float>, indices : Array<Int>) : Geometry
    {
        var g = new Geometry();
        g.positionsFromArray(positions);
        g.indices = indices.copy();
        var i = 0;
        do {
            g.colors.push((i % 2 == 0) ? RGB.RGBh(0xffffff) : RGB.RGBh(0x999999));
        } while (i++ < positions.length);
        return g;
    }
}