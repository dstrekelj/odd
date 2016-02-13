package odd.geom;
import odd.math.OddVec3;
import odd.render.OddRenderMethod;
import odd.util.color.OddRGB;

class OddGeometry
{
    public var positions : Array<OddVec3>;
    public var colors : Array<OddRGB>;
    public var faces : Array<Array<Int>>;
    
    function new()
    {
        positions = new Array<OddVec3>();
        colors = new Array<OddRGB>();
        faces = new Array<Array<Int>>();
    }
    
    public static inline function fromArray(array : Array<Float>) : OddGeometry
    {
        var g = new OddGeometry();
        
        var i : Int = 0;
        do {
            g.positions.push(OddVec3.fromArray(array.slice(i, i + 3)));
        } while ((i += 3) < array.length);
        
        return g;
    }
}