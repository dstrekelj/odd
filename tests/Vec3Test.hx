package tests;

import haxe.ds.Vector;
import haxe.unit.TestCase;
import odd.math.Vec3;

class Vec3Test extends TestCase
{
    public function testNew()
    {
        var v1 = new Vector3(-2, 0, 10.3);
        var v2 = new Vector3();
        var v3 = new Vector3(1);
        
        this.assertEquals(Std.string(v1), '{ -2, 0, 10.3 }');
        this.assertEquals(Std.string(v2), '{ 0, 0, 0 }');
        this.assertEquals(Std.string(v3), '{ 1, 0, 0 }');
    }
    
    public function testLength()
    {
        var v1 = new Vector3(0, 0, 0);
        var v2 = new Vector3(1, 0, 0);
        var v3 = new Vector3(-0.2, 13.3, 2);
        
        this.assertEquals(v1.length, 0);
        this.assertEquals(v2.length, 1);
        this.assertEquals(v3.length, Math.sqrt(v3.x * v3.x + v3.y * v3.y + v3.z * v3.z));
    }
    
    public function testNegate()
    {
        var v1 = new Vector3(0, 0, 0);
        var v2 = new Vector3(1, -2, -3);
        
        this.assertEquals(Std.string(-v1), '{ 0, 0, 0 }');
        this.assertEquals(Std.string(-v1), Std.string(v1));
        this.assertEquals(Std.string(-v2), '{ -1, 2, 3 }');
    }
    
    public function testAdd()
    {
        var v1 = new Vector3();
        var v2 = new Vector3(10, -2.5, 3);
        
        this.assertEquals(Std.string(v1 + v2), '{ 10, -2.5, 3 }');
        this.assertEquals(Std.string(v1 + v2), Std.string(v2));
        this.assertEquals(Std.string(v2 + v1), '{ 10, -2.5, 3 }');
        this.assertEquals(Std.string(v2 + v1), Std.string(v2));
    }
    
    public function testSubtract()
    {
        var v1 = new Vector3();
        var v2 = new Vector3(10, -2.5, 3);
        
        this.assertEquals(Std.string(v1 - v2), '{ -10, 2.5, -3 }');
        this.assertEquals(Std.string(v2 - v1), '{ 10, -2.5, 3 }');
        this.assertEquals(Std.string(v2 - v1), Std.string(v2));
    }
    
    public function testMultiply()
    {
        var v1 = new Vector3();
        var v2 = new Vector3(1, 1, 1);
        var v3 = new Vector3(0, -2, 0.5);
        
        this.assertEquals(Std.string(v1 * 2), '{ 0, 0, 0 }');
        this.assertEquals(Std.string(v2 * 2), '{ 2, 2, 2 }');
        this.assertEquals(Std.string(v3 * 2), '{ 0, -4, 1 }');
    }
    
    public function testDivide()
    {
        var v1 = new Vector3();
        var v2 = new Vector3(1, 1, 1);
        var v3 = new Vector3(0, -2, 0.5);
        
        this.assertEquals(Std.string(v1 / 2), '{ 0, 0, 0 }');
        this.assertEquals(Std.string(v2 / 2), '{ 0.5, 0.5, 0.5 }');
        this.assertEquals(Std.string(v3 / 2), '{ 0, -1, 0.25 }');
    }
    
    public function testDotProduct()
    {
        var v1 = new Vector3();
        var v2 = new Vector3(1, 1, 1);
        var v3 = new Vector3(0, -2, 0.5);
        
        this.assertEquals(v1 * v2, 0);
        this.assertEquals(v2 * v1, 0);
        this.assertEquals(v2 * v2, 3);
        this.assertEquals(v2 * v3, -1.5);
        this.assertEquals(v3 * v2, -1.5);
    }
    
    public function testCrossProduct()
    {
        var v1 = new Vector3();
        var v2 = new Vector3(1, -3, 5);
        var v3 = new Vector3(2, -4, 6);
        
        this.assertEquals(Std.string(v1 % v2), '{ 0, 0, 0 }');
        this.assertEquals(Std.string(v2 % v1), '{ 0, 0, 0 }');
        this.assertEquals(Std.string(v1 % v1), '{ 0, 0, 0 }');
        this.assertEquals(Std.string(v2 % v3), '{ 2, 4, 2 }');
        this.assertEquals(Std.string(v3 % v2), '{ -2, -4, -2 }');
    }
    
    public function testNormalize()
    {
        var v1 = new Vector3(1, -3, 5);
        
        this.assertEquals(v1.normalize().length, 1);
    }
}