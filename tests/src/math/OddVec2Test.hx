package math;

import haxe.unit.TestCase;
import odd.math.Vec2;

class OddVec2Test extends TestCase
{
    /*
    public function testFromArrayFloat()
    {
        var v1 : OddVec2 = [ -2, 0.4, 20, 1];
        var v2 : OddVec2 = [];
        
        assertEquals(Std.string(v1), Std.string([-2, 0.4]));
        assertEquals(Std.string(v2), Std.string([null, null]));
    }
    
    public function testFromArrayInt()
    {
        var v1 : OddVec2 = [ -2, 0, 20, 1];
        var v2 : OddVec2 = [];
        
        assertEquals(Std.string(v1), Std.string([-2, 0]));
        assertEquals(Std.string(v2), Std.string([null, null]));
    }
    
    public function testFromOddVec3()
    {
        var v1 = new OddVec3(1, 2, 3);
        var v2 : OddVec2 = v1;
        
        assertEquals(Std.string(v2), Std.string([1, 2]));
    }
    
    public function testFromOddVec4()
    {
        var v1 = new OddVec4(1, 2, 3, 4);
        var v2 : OddVec2 = v1;
        
        assertEquals(Std.string(v2), Std.string([1, 2]));
    }
    */
    
    public function testNew()
    {
        var v1 = new Vec2( -2, 0.4);
        var v2 = new Vec2();
        
        assertEquals(Std.string(v1), Std.string([-2, 0.4]));
        assertEquals(Std.string(v2), Std.string([null, null]));
    }
    
    public function testFromArray()
    {
        var v1 = Vec2.fromArray([1, 2, 3, 4]);
        var v2 = Vec2.fromArray([]);
        
        assertEquals(Std.string(v1), Std.string([1, 2]));
        assertEquals(Std.string(v2), Std.string([null, null]));
    }
    
    public function testGet()
    {
        var v : Vec2 = Vec2.fromArray([ -0.5, 2]);
        
        assertEquals(v.x, -0.5);
        assertEquals(v.y, 2);
    }
    
    public function testSet()
    {
        var v : Vec2 = Vec2.fromArray([ -0.5, 2]);
        v.x = 0;
        v.y = 10.1;
        
        assertEquals(Std.string(v), Std.string([0, 10.1]));
    }
    
    public function testLength()
    {
        var v : Vec2 = Vec2.fromArray([-1, 2.5]);
        
        assertEquals(v.length, Math.sqrt( -1 * -1 + 2.5 * 2.5));
    }
    
    public function testNegate()
    {
        var v : Vec2 = Vec2.fromArray([ -1, -2.5]);
        
        assertEquals(Std.string( -v), Std.string([1, 2.5]));
    }
    
    public function testAdd()
    {
        var v1 : Vec2 = Vec2.fromArray([0, 2]);
        var v2 : Vec2 = Vec2.fromArray([ -1, 1]);
        
        assertEquals(Std.string(v1 + v2), Std.string([ -1, 3]));
        assertEquals(Std.string(v2 + v1), Std.string([ -1, 3]));
    }
    
    public function testSubtract()
    {
        var v1 : Vec2 = Vec2.fromArray([0, 2]);
        var v2 : Vec2 = Vec2.fromArray([ -1, 1]);
        
        assertEquals(Std.string(v1 - v2), Std.string([1, 1]));
        assertEquals(Std.string(v2 - v1), Std.string([-1, -1]));
    }
    
    public function testMultiplyScalar()
    {
        var v : Vec2 = Vec2.fromArray([0, 2.5]);
        
        assertEquals(Std.string(v * -1), Std.string([0, -2.5]));
        assertEquals(Std.string(v * 0), Std.string([0, 0]));
    }
    
    public function testDivideScalar()
    {
        var v : Vec2 = Vec2.fromArray([0, 2.5]);
        
        assertEquals(Std.string(v / 2), Std.string([0, 1.25]));
        assertEquals(Std.string(v / 0.5), Std.string([0, 5]));
    }
    
    public function testDotProduct()
    {
        var v1 : Vec2 = Vec2.fromArray([0, -2]);
        var v2 : Vec2 = Vec2.fromArray([10, -0.5]);
        
        assertEquals(v1 * v2, 1);
        assertEquals(v2 * v1, 1);
    }
    
    public function testCrossProduct()
    {
        var v1 : Vec2 = Vec2.fromArray([0, -2]);
        var v2 : Vec2 = Vec2.fromArray([10, -0.5]);
        
        assertEquals(v1 % v2, 20);
        assertEquals(v2 % v1, -20);
    }
    
    public function testNormalize()
    {
        var v : Vec2 = Vec2.fromArray([1, 0]);
        
        assertEquals(Std.string(v.normalize()), Std.string([1, 0]));
    }
}