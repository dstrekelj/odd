package odd.math;
import haxe.ds.Vector;

/**
 * Four-component vector of `Float` types.
 */
private class Vector4 {
    public var x : Float;   public var y : Float;   public var z : Float;   public var w : Float;
    
    public inline function new(x : Float, y : Float, z : Float, w : Float) : Void {
        this.x = x; this.y = y; this.z = z; this.w = w;
    }
    
    public inline function toString() : String {
        return '{ x : $x, y : $y, z : $z, w : $w }';
    }
}

abstract Vec4(Vector4)
{
    inline public function new(x : Float, y : Float, z : Float, w : Float)
    {
        this = new Vector4(
            x,  y,  z,  w
        );
    }
    
    public var x(get, set) : Float;
    inline function get_x() return this.x;
    inline function set_x(x : Float) return this.x = x;
    
    public var y(get, set) : Float;
    inline function get_y() return this.y;
    inline function set_y(y : Float) return this.y = y;
    
    public var z(get, set) : Float;
    inline function get_z() return this.z;
    inline function set_z(z : Float) return this.z = z;
    
    public var w(get, set) : Float;
    inline function get_w() return this.w;
    inline function set_w(w : Float) return this.w = w;
    
    public var length(get, never) : Float;
    inline function get_length() return Math.sqrt(dot(new Vec4(x, y, z, w)));
    
    public static inline function fromArray(a : Array<Float>) : Vec4
    {
        return new Vec4(
            a[0],   a[1],   a[2],   a[3]
        );
    }
    
    @:op(-A)
    public inline function neg() : Vec4
    {
        return new Vec4(
            -x, -y, -z, -w
        );
    }
    
    @:op(A + B)
    public inline function add(B : Vec4) : Vec4
    {
        return new Vec4(
            x + B.x,    y + B.y,    z + B.z,    w + B.w
        );
    }
    
    @:op(A - B)
    public inline function sub(B : Vec4) : Vec4
    {
        return new Vec4(
            x - B.x,    y - B.y,    z - B.z,    w - B.w
        );
    }
    
    @:op(A * B)
    public inline function mul(B : Float) : Vec4
    {
        return new Vec4(
            x * B,  y * B,  z * B,  w * B
        );
    }
    
    @:op(A * B)
    public inline function mulMat4x4(B : Mat4x4) : Vec4
    {
        return new Vec4(
            x * B.xx + y * B.yx + z * B.zx + w * B.wx,  x * B.xy + y * B.yy + z * B.zy + w * B.wy,  x * B.xz + y * B.yz + z * B.zz + w * B.wz,  x * B.xw + y * B.yw + z * B.zw + w * B.ww
        );
    }
    
    @:op(A / B)
    public inline function div(B : Float) : Vec4
    {
        return new Vec4(
            x / B,  y / B,  z / B,  w / B
        );
    }
    
    @:op(A * B)
    public inline function dot(B : Vec4) : Float
    {
        return x * B.x + y * B.y + z * B.z + w * B.w;
    }
    
    public inline function normalize() : Vec4
    {
        return new Vec4(
            x / length, y / length, z / length, w / length
        );
    }
}
