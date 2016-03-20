package odd.geom;

import odd.math.OddVec3;
import odd.render.OddRenderMethod;
import odd.util.color.OddRGB;

class OddGeometry
{
    public var positions : Array<OddVec3>;
    public var colors : Array<OddRGB>;
    public var indices : Array<Int>;
    
    public function new()
    {
        positions = new Array<OddVec3>();
        colors = new Array<OddRGB>();
        indices = new Array<Int>();
    }
    
    public inline function positionsFromArray(array : Array<Float>) : Void
    {   
        var i : Int = 0;
        do {
            positions.push(OddVec3.fromArray(array.slice(i, i + 3)));
        } while ((i += 3) < array.length);
    }
    
    public inline function colorsFromArrayInt(array : Array<Int>) : Void
    {
        var i : Int = 0;
        do {
            colors.push(OddRGB.RGB(array[i]));
        } while (i++ < array.length);
    }
    
    public inline function colorsFromArrayFloat(array : Array<Float>) : Void
    {
        var i : Int = 0;
        do {
            colors.push(OddRGB.RGBf(array[i], array[i + 1], array[i + 2]));
        } while ((i += 3) < array.length);
    }
    
    public inline function clone() : OddGeometry
    {
        var g = new OddGeometry();
        g.positions = this.positions.copy();
        g.colors = this.colors.copy();
        g.indices = this.indices.copy();
        return g;
    }
    
    @:allow(odd.macro.OddLoaderMacros)
    public static inline function fromGeometryData(positions : Array<Float>, indices : Array<Int>) : OddGeometry
    {
        var g = new OddGeometry();
        g.positionsFromArray(positions);
        g.indices = indices.copy();
        var i = 0;
        do {
            g.colors.push((i % 2 == 0) ? OddRGB.RGB(0xffffff) : OddRGB.RGB(0x999999));
        } while (i++ < positions.length);
        return g;
    }
}