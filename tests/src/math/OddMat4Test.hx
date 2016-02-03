package math;

import haxe.unit.TestCase;
import odd.math.OddMat4;

class OddMat4Test extends TestCase
{
    var I : Array<Float> = [
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
    ];
    
    var E : Array<Float> = [
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0
    ];
    
    public function testFromArrayFloat()
    {
        var m1 : OddMat4 = OddMat4.fromArray([0.2, 1, -30, 2.25]);
        var m2 : OddMat4 = OddMat4.fromArray([
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0,
            17.0, 18.0, 19.0
        ]);
        var m3 : OddMat4 = OddMat4.fromArray([]);
        
        assertEquals(Std.string(m1), Std.string([0.2, 1, -30, 2.25, null, null, null, null, null, null, null, null, null, null, null, null]));
        assertEquals(Std.string(m2), Std.string([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        assertEquals(Std.string(m3), Std.string([null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]));
    }
    
    public function testFromArrayInt()
    {
        var m1 : OddMat4 = OddMat4.fromArray([0, 1, -3, 2]);
        var m2 : OddMat4 = OddMat4.fromArray([
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 15, 16,
            17, 18, 19
        ]);
        var m3 : OddMat4 = OddMat4.fromArray([]);
        
        assertEquals(Std.string(m1), Std.string([0, 1, -3, 2, null, null, null, null, null, null, null, null, null, null, null, null]));
        assertEquals(Std.string(m2), Std.string([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        assertEquals(Std.string(m3), Std.string([null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]));
    }
    
    public function testNew()
    {
        var m1 = new OddMat4(0, 1, -3, 2);
        var m2 = new OddMat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        
        assertEquals(Std.string(m1), Std.string([0, 1, -3, 2, null, null, null, null, null, null, null, null, null, null, null, null]));
        assertEquals(Std.string(m2), Std.string([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
    }
    
    public function testGetSet()
    {
        var m : OddMat4 = OddMat4.fromArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        
        m.xx = 10;  m.xy = 20;  m.xz = 30;  m.xw = 40;
        m.yx = 50;  m.yy = 60;  m.yz = 70;  m.yw = 80;
        m.zx = 90;  m.zy = 100; m.zz = 110; m.zw = 120;
        m.wx = 130; m.wy = 140; m.wz = 150; m.ww = 160;
        
        assertEquals(Std.string(m), Std.string([10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160]));
    }
    
    public function testIdentity()
    {
        var m : OddMat4 = OddMat4.identity();
        
        assertEquals(Std.string(m), Std.string(I));
    }
    
    public function testEmpty()
    {
        var m : OddMat4 = OddMat4.empty();
        
        assertEquals(Std.string(m), Std.string(E));
    }
    
    public function testTranslate()
    {
        var m : OddMat4 = OddMat4.translate(0, 2, -1);
        var r : Array<Int> = [
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 2, -1, 1
        ];
        
        assertEquals(Std.string(m), Std.string(r));
    }
    
    public function testScale()
    {
        var m : OddMat4 = OddMat4.scale(2, -5, 0.5);
        var r : Array<Float> = [
            2, 0, 0, 0,
            0, -5, 0, 0,
            0, 0, 0.5, 0,
            0, 0, 0, 1
        ];
        
        assertEquals(Std.string(m), Std.string(r));
    }
    
    public function testNegate()
    {
        var m : OddMat4 = OddMat4.fromArray([
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 15, 16
        ]);
        var r : Array<Int> = [
            -1, -2, -3, -4,
            -5, -6, -7, -8,
            -9, -10, -11, -12,
            -13, -14, -15, -16
        ];
        
        assertEquals(Std.string(-m), Std.string(r));
    }
    
    public function testAdd()
    {
        var m1 : OddMat4 = OddMat4.fromArray([
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
        ]);
        
        var m2 : OddMat4 = OddMat4.fromArray([
            -1, -1, -1, -1,
            -1, -1, -1, -1,
            -1, -1, -1, -1,
            -1, -1, -1, -1
        ]);
        
        this.assertEquals(Std.string(m1 + m2), Std.string(E));
    }
    
    public function testSubtract()
    {
        var m1 : OddMat4 = OddMat4.fromArray([
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
        ]);
        
        this.assertEquals(Std.string(m1 - m1), Std.string(E));
    }
    
    public function testMultiplyScalar()
    {
        var m : OddMat4 = OddMat4.fromArray([
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
        ]);
        
        this.assertEquals(Std.string(m * 0), Std.string(E));
    }
    
    public function testMultiplyMatrix()
    {
        var m1 : OddMat4 = OddMat4.fromArray([
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 15, 16
        ]);
        var m2 : OddMat4 = OddMat4.fromArray([
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 15, 16
        ]);
        var r : Array<Int> = [
            90, 100, 110, 120,
            202, 228, 254, 280,
            314, 356, 398, 440,
            426, 484, 542, 600
        ];
        
        this.assertEquals(Std.string(m1 * m2), Std.string(r));
    }
}