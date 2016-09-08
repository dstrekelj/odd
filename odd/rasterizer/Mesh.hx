package odd.rasterizer;

import odd.math.Mat4x4;
import odd.rasterizer.Geometry;
import odd.Texture;

/**
 * Mesh.
 */
class Mesh
{
    public var geometry : Geometry;
    public var texture : Texture;
    public var transform : Mat4x4;
    
    public function new(geometry : Geometry)
    {
        this.geometry = geometry.clone();
        this.transform = Mat4x4.identity();
        this.texture = null;
    }
}