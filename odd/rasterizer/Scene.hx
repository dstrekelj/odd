package odd.rasterizer;

import odd.rasterizer.Camera;
import odd.rasterizer.Mesh;

@:allow(odd.rasterizer.pipeline.Pipeline)
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