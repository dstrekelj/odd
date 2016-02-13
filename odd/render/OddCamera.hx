package odd.render;
import odd.math.OddMat4;
import odd.math.OddVec3;

class OddCamera
{
    public var position : OddVec3;
    
    public var matrix : OddMat4;

    public function new() 
    {
        position = new OddVec3(0, 0, 0);
        matrix = OddMat4.identity();
    }
}