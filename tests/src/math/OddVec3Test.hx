package math;

import haxe.unit.TestCase;
import odd.math.Mat4;
import odd.math.Vec3;
import odd.math.Vec4;

class OddVec3Test extends TestCase
{
    /*
    public function testFromArrayFloat()
    {
        var v1 : OddVec3 = [ -2, 0.4, 20, 1];
        var v2 : OddVec3 = [];
        
        assertEquals(Std.string(v1), Std.string([-2, 0.4, 20]));
        assertEquals(Std.string(v2), Std.string([null, null, null]));
    }
    
    public function testFromArrayInt()
    {
        var v1 : OddVec3 = [ -2, 0, 20, 1];
        var v2 : OddVec3 = [];
        
        assertEquals(Std.string(v1), Std.string([-2, 0, 20]));
        assertEquals(Std.string(v2), Std.string([null, null, null]));
    }
    
    public function testFromOddVec4()
    {
        var v1 = new OddVec4(1, 2, 3, 4);
        var v2 : OddVec3 = v1;
        
        assertEquals(Std.string(v2), Std.string([1, 2, 3]));
    }
    */
    
    public function testNew()
    {
        var v1 = new Vec3( -2, 0.4, 20);
        var v2 = new Vec3();
        
        assertEquals(Std.string(v1), Std.string([-2, 0.4, 20]));
        assertEquals(Std.string(v2), Std.string([null, null, null]));
    }
    
    public function testFromArray()
    {
        var v1 = Vec3.fromArray([1, 2, 3, 4]);
        var v2 = Vec3.fromArray([]);
        
        assertEquals(Std.string(v1), Std.string([1, 2, 3]));
        assertEquals(Std.string(v2), Std.string([null, null, null]));
    }
    
    public function testGet()
    {
        var v : Vec3 = Vec3.fromArray([ -0.5, 2, 0]);
        
        assertEquals(v.x, -0.5);
        assertEquals(v.y, 2);
        assertEquals(v.z, 0);
    }
    
    public function testSet()
    {
        var v : Vec3 = Vec3.fromArray([ -0.5, 2, 0]);
        v.x = 0;
        v.y = 10.1;
        v.z = -1;
        
        assertEquals(Std.string(v), Std.string([0, 10.1, -1]));
    }
    
    public function testLength()
    {
        var v : Vec3 = Vec3.fromArray([-1, 2.5, 1]);
        
        assertEquals(v.length, Math.sqrt( -1 * -1 + 2.5 * 2.5 + 1 * 1));
    }
    
    public function testNegate()
    {
        var v : Vec3 = Vec3.fromArray([ -1, -2.5, 1]);
        
        assertEquals(Std.string( -v), Std.string([1, 2.5, -1]));
    }
    
    public function testAdd()
    {
        var v1 : Vec3 = Vec3.fromArray([0, 2, 1]);
        var v2 : Vec3 = Vec3.fromArray([ -1, 1, -1]);
        
        assertEquals(Std.string(v1 + v2), Std.string([ -1, 3, 0]));
        assertEquals(Std.string(v2 + v1), Std.string([ -1, 3, 0]));
    }
    
    public function testSubtract()
    {
        var v1 : Vec3 = Vec3.fromArray([0, 2, 1]);
        var v2 : Vec3 = Vec3.fromArray([ -1, 1, -1]);
        
        assertEquals(Std.string(v1 - v2), Std.string([1, 1, 2]));
        assertEquals(Std.string(v2 - v1), Std.string([-1, -1, -2]));
    }
    
    public function testMultiplyScalar()
    {
        var v : Vec3 = Vec3.fromArray([0, 2.5, 1]);
        
        assertEquals(Std.string(v * -1), Std.string([0, -2.5, -1]));
        assertEquals(Std.string(v * 0), Std.string([0, 0, 0]));
    }
    
    public function testMultiplyMat4()
    {
        var v : Vec3 = Vec3.fromArray([0, 5, -5]);
        var m : Mat4 = Mat4.translate( -10, 5, 0);
        
        assertEquals(Std.string(v * m), Std.string([-10, 10, -5]));
    }
    
    public function testDivideScalar()
    {
        var v : Vec3 = Vec3.fromArray([0, 2.5, 1]);
        
        assertEquals(Std.string(v / 2), Std.string([0, 1.25, 0.5]));
        assertEquals(Std.string(v / 0.5), Std.string([0, 5, 2]));
    }
    
    public function testDotProduct()
    {
        var v1 : Vec3 = Vec3.fromArray([0, -2, 1]);
        var v2 : Vec3 = Vec3.fromArray([10, -0.5, 1]);
        
        assertEquals(Std.string(v1*v2), Std.string(0 * 10 + (-2) * (-0.5) + 1 * 1));
        assertEquals(Std.string(v2*v1), Std.string(10 * 0 + (-0.5) * (-2) + 1 * 1));
    }
    
    public function testCrossProduct()
    {
        var v1 : Vec3 = Vec3.fromArray([2, 2, 2]);
        var v2 : Vec3 = Vec3.fromArray([-2, -2, -2]);
        
        assertEquals(Std.string(v1 % v2), Std.string([0, 0, 0]));
        assertEquals(Std.string(v2 % v1), Std.string([0, 0, 0]));
    }
    
    public function testNormalize()
    {
        var v : Vec3 = Vec3.fromArray([1, 0, 0]);
        
        assertEquals(Std.string(v.normalize()), Std.string([1, 0, 0]));
    }
}