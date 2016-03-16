package odd.geom;
import odd.math.OddMat4;
import odd.math.OddVec3;
import odd.render.OddCullMethod;
import odd.render.OddRenderMethod;

class OddMesh
{
    public var geometry : OddGeometry;
    public var transform : OddMat4;
    public var renderMethod : OddRenderMethod;
    public var cullMethod : OddCullMethod;
    
    public function new(geometry : OddGeometry)
    {
        this.geometry = geometry.clone();
        this.transform = OddMat4.identity();
        renderMethod = OddRenderMethod.TRIANGLE;
        cullMethod = OddCullMethod.CLOCKWISE;
    }
    
    public function translate(x : Float, y : Float, z : Float) : Void
    {
        transform *= OddMat4.translate(x, y, z);
    }
}