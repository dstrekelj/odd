package odd.rasterizer.object;

import odd.rasterizer.object.Mesh;
import odd.rasterizer.object.Camera;

@:allow(odd.rasterizer.Pipeline)
class Scene
{
    var meshes : Array<Mesh>;
    var camera : Camera;
    
    public function new() 
    {
        meshes = new Array<Mesh>();
        camera = new Camera();
    }

    public inline function addMesh(mesh : Mesh) : Void
    {
        this.meshes.push(mesh);
    }

    public inline function removeMesh(mesh : Mesh) : Void
    {
        this.meshes.remove(mesh);
    }

    public inline function setCamera(camera : Camera) : Void
    {
        this.camera = camera;
    }
}