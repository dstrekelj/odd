package odd.render;
import odd.geom.OddMesh;

class OddScene
{
    public var meshes : Array<OddMesh>;
    public var camera : OddCamera;

    public function new()
    {
        meshes = new Array<OddMesh>();
        camera = new OddCamera();
    }
}