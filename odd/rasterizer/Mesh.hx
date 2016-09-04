package odd.rasterizer;

import odd.math.Mat4x4;
import odd.rasterizer.pipeline.RenderMethod;
import odd.rasterizer.Geometry;

/**
 * Mesh.
 */
class Mesh
{
    public var geometry : Geometry;
    public var transform : Mat4x4;
    public var renderMethod : RenderMethod;
    
    public function new(geometry : Geometry)
    {
        this.geometry = geometry.clone();
        this.transform = Mat4x4.identity();
        this.renderMethod = RenderMethod.Point;
    }
}