package odd.render;
import odd.math.Mat4;
import odd.math.Vec3;

class Camera
{
    public var position : Vec3;
    
    public var matrix : Mat4;

    public function new() 
    {
        position = new Vec3(0, 0, 0);
        matrix = Mat4.identity();
    }
}