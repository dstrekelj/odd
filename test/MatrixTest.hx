package test;
import haxe.unit.TestCase;
import odd.math.Mat4;
import odd.math.Vec4.Vector4;

class MatrixTest extends TestCase
{
    var I : Matrix4;
    var E : Matrix4;
    
    inline static var IDENTITY : String = '{ { 1, 0, 0, 0 }, { 0, 1, 0, 0 }, { 0, 0, 1, 0 }, { 0, 0, 0, 1 } }';
    inline static var EMPTY : String = '{ { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 } }';
    
    public function new()
    {
        super();
        
        I = Matrix4.identity();
        E = Matrix4.empty();
    }
    
    public function testIdentity()
    {
        var X = new Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1
        );
        
        this.assertEquals(Std.string(X), Std.string(I));
        this.assertEquals(Std.string(I), IDENTITY);
        this.assertEquals(Std.string(X), IDENTITY);
    }
    
    public function testEmpty()
    {
        var X = new Matrix4(
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        );
        
        this.assertEquals(Std.string(X), Std.string(E));
        this.assertEquals(Std.string(E), EMPTY);
        this.assertEquals(Std.string(X), EMPTY);
    }
    
    public function testTranslate()
    {
        var X = new Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 2, -1, 1
        );
        var Y = Matrix4.translate(0, 2, -1);
        var S = '{ { 1, 0, 0, 0 }, { 0, 1, 0, 0 }, { 0, 0, 1, 0 }, { 0, 2, -1, 1 } }';
        
        this.assertEquals(Std.string(X), Std.string(Y));
        this.assertEquals(Std.string(X), S);
        this.assertEquals(Std.string(Y), S);
    }
    
    public function testScale()
    {
        var X = new Matrix4(
            2, 0, 0, 0,
            0, -5, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 1
        );
        var Y = Matrix4.scale(2, -5, 0);
        var S = '{ { 2, 0, 0, 0 }, { 0, -5, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 1 } }';
        
        this.assertEquals(Std.string(X), Std.string(Y));
        this.assertEquals(Std.string(X), S);
        this.assertEquals(Std.string(Y), S);
    }
    
    public function testNegate()
    {
        var X = new Matrix4(
            -1, 1, -1, 1,
            -1, 1, -1, 1,
            -1, 1, -1, 1,
            -1, 1, -1, 1
        );
        var S = '{ { 1, -1, 1, -1 }, { 1, -1, 1, -1 }, { 1, -1, 1, -1 }, { 1, -1, 1, -1 } }';
        
        this.assertEquals(Std.string(-X), S);
    }
    
    public function testAdd()
    {
        var X = new Matrix4(
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
        );
        
        var Y = new Matrix4(
            -1, -1, -1, -1,
            -1, -1, -1, -1,
            -1, -1, -1, -1,
            -1, -1, -1, -1
        );
        
        this.assertEquals(Std.string(X + Y), EMPTY);
    }
    
    public function testSubtract()
    {
        var X = new Matrix4(
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
        );
        
        var Y = new Matrix4(
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
        );
        
        this.assertEquals(Std.string(X - Y), EMPTY);
    }
    
    public function testScalarProduct()
    {
        var X = new Matrix4(
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1,
            1, 1, 1, 1
        );
        
        this.assertEquals(Std.string(X * 0), EMPTY);
    }
    
    public function testVectorProduct()
    {
        var X = Matrix4.translate( -10, 5, 0.5);
        
        var Y = new Vector4(20, -13, 0.5, 1);
        
        var S = '{ 10, -8, 1, 1 }';
        
        this.assertEquals(Std.string(X * Y), S);
    }
    
    public function testMatrixProduct()
    {
        var X = new Matrix4(
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 15, 16
        );
        
        var Y = new Matrix4(
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 15, 16
        );
        
        var S = '{ { 90, 100, 110, 120 }, { 202, 228, 254, 280 }, { 314, 356, 398, 440 }, { 426, 484, 542, 600 } }';
        
        this.assertEquals(Std.string(X * Y), S);
    }
}