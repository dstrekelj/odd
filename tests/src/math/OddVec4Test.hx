package math;

import haxe.unit.TestCase;
import odd.math.OddVec4;

class OddVec4Test extends TestCase
{
    public function testFromArrayFloat()
    {
        var v1 : OddVec4 = OddVec4.fromArray([ -2, 0.4, 20, 1, 5.5]);
        var v2 : OddVec4 = OddVec4.fromArray([]);
        
        assertEquals(Std.string(v1), Std.string([-2, 0.4, 20, 1]));
        assertEquals(Std.string(v2), Std.string([null, null, null, null]));
    }
    
    public function testFromArrayInt()
    {
        var v1 : OddVec4 = OddVec4.fromArray([ -2, 0, 20, 1, 5.5]);
        var v2 : OddVec4 = OddVec4.fromArray([]);
        
        assertEquals(Std.string(v1), Std.string([-2, 0, 20, 1]));
        assertEquals(Std.string(v2), Std.string([null, null, null, null]));
    }
    
    public function testNew()
    {
        var v1 = new OddVec4( -2, 0.4, 20, 1);
        var v2 = new OddVec4();
        
        assertEquals(Std.string(v1), Std.string([-2, 0.4, 20, 1]));
        assertEquals(Std.string(v2), Std.string([null, null, null, null]));
    }
    
    public function testGet()
    {
        var v : OddVec4 = OddVec4.fromArray([ -0.5, 2, 0, 1]);
        
        assertEquals(v.x, -0.5);
        assertEquals(v.y, 2);
        assertEquals(v.z, 0);
        assertEquals(v.w, 1);
    }
    
    public function testSet()
    {
        var v : OddVec4 = OddVec4.fromArray([ -0.5, 2, 0, 1]);
        v.x = 0;
        v.y = 10.1;
        v.z = -1;
        v.w = 0.1;
        
        assertEquals(Std.string(v), Std.string([0, 10.1, -1, 0.1]));
    }
    
    public function testLength()
    {
        var v : OddVec4 = OddVec4.fromArray([-1, 2.5, 1, 2]);
        
        assertEquals(v.length, Math.sqrt( -1 * -1 + 2.5 * 2.5 + 1 * 1 + 2 * 2));
    }
    
    public function testNegate()
    {
        var v : OddVec4 = OddVec4.fromArray([ -1, -2.5, 1, 2.5]);
        
        assertEquals(Std.string( -v), Std.string([1, 2.5, -1, -2.5]));
    }
    
    public function testAdd()
    {
        var v1 : OddVec4 = OddVec4.fromArray([0, 2, 1, 0]);
        var v2 : OddVec4 = OddVec4.fromArray([ -1, 1, -1, 5]);
        
        assertEquals(Std.string(v1 + v2), Std.string([ -1, 3, 0, 5]));
        assertEquals(Std.string(v2 + v1), Std.string([ -1, 3, 0, 5]));
    }
    
    public function testSubtract()
    {
        var v1 : OddVec4 = OddVec4.fromArray([0, 2, 1, 0]);
        var v2 : OddVec4 = OddVec4.fromArray([ -1, 1, -1, 5]);
        
        assertEquals(Std.string(v1 - v2), Std.string([1, 1, 2, -5]));
        assertEquals(Std.string(v2 - v1), Std.string([-1, -1, -2, 5]));
    }
    
    public function testMultiplyScalar()
    {
        var v : OddVec4 = OddVec4.fromArray([0, 2.5, 1, 5]);
        
        assertEquals(Std.string(v * -1), Std.string([0, -2.5, -1, -5]));
        assertEquals(Std.string(v * 0), Std.string([0, 0, 0, 0]));
    }
    
    public function testDivideScalar()
    {
        var v : OddVec4 = OddVec4.fromArray([0, 2.5, 1, 5]);
        
        assertEquals(Std.string(v / 2), Std.string([0, 1.25, 0.5, 2.5]));
        assertEquals(Std.string(v / 0.5), Std.string([0, 5, 2, 10]));
    }
    
    public function testDotProduct()
    {
        var v1 : OddVec4 = OddVec4.fromArray([0, -2, 1, 5]);
        var v2 : OddVec4 = OddVec4.fromArray([10, -0.5, 1, 2]);
        
        assertEquals(Std.string(v1 * v2), Std.string(0 * 10 + (-2) * (-0.5) + 1 * 1 + 5 * 2));
        assertEquals(Std.string(v2 * v1), Std.string(10 * 0 + (-0.5) * (-2) + 1 * 1 + 2 * 5));
    }
    
    public function testNormalize()
    {
        var v : OddVec4 = OddVec4.fromArray([1, 0, 0, 0]);
        
        assertEquals(Std.string(v.normalize()), Std.string([1, 0, 0, 0]));
    }
}