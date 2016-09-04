package odd.rasterizer;

import odd.math.Mat4x4;

@:allow(odd.rasterizer.pipeline.Pipeline)
class Camera
{
    var transformProjection : Mat4x4;
    var transformView : Mat4x4;

    public function new() : Void
    {
        transformView = Mat4x4.identity();
        transformProjection = Mat4x4.identity();
    }

    public function setProjectionTransform(transform : Mat4x4) : Void
    {
        transformProjection = transform; 
    }

    public function translate(x : Float, y : Float, z : Float)
    {
        transformView = transformView * Mat4x4.translate(-x, -y, -z);
    }
}