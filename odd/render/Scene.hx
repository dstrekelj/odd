package odd.render;
import odd.geom.Mesh;

class Scene
{
    public var meshes : Array<Mesh>;
    public var camera : Camera;

    public function new()
    {
        meshes = new Array<Mesh>();
        camera = new Camera();
    }
}