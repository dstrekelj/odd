package odd.geom;
import odd.math.Mat4;
import odd.math.Vec3;
import odd.render.CullMethod;
import odd.render.RenderMethod;

class Mesh
{
    public var geometry : Geometry;
    public var transform : Mat4;
    public var renderMethod : RenderMethod;
    public var cullMethod : CullMethod;
    
    public function new(geometry : Geometry)
    {
        this.geometry = geometry.clone();
        this.transform = Mat4.identity();
        renderMethod = RenderMethod.TRIANGLE;
        cullMethod = CullMethod.CLOCKWISE;
    }
    
    public function translate(x : Float, y : Float, z : Float) : Void
    {
        transform *= Mat4.translate(x, y, z);
    }
}