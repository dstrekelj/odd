package test;
import haxe.unit.TestCase;
import odd.math.Mat4;

class MathTest extends TestCase
{
    var A : Matrix4;
    var B : Matrix4;
    
    public function new()
    {
        super();
        
        A = Matrix4.identity();
        B = Matrix4.empty();
    }
    
    public function testAddition()
    {
        var R : Matrix4 = A - B;
        this.assertEquals(R, A);
    }
}