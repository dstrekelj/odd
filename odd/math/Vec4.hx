package odd.math;

/**
 * Four-component vector of `Float` types.
 */
abstract Vec4(Array<Float>)
{
    inline public function new(x : Float, y : Float, z : Float, w : Float) this = [x, y, z, w];
    
    public var x(get, set) : Float;
    inline function get_x() return this[0];
    inline function set_x(x : Float) return this[0] = x;
    
    public var y(get, set) : Float;
    inline function get_y() return this[1];
    inline function set_y(y : Float) return this[1] = y;
    
    public var z(get, set) : Float;
    inline function get_z() return this[2];
    inline function set_z(z : Float) return this[2] = z;
    
    public var w(get, set) : Float;
    inline function get_w() return this[3];
    inline function set_w(w : Float) return this[3] = w;
    
    public var length(get, never) : Float;
    inline function get_length() return Math.sqrt(dot(fromArray(this)));
    
    public static inline function fromArray(a : Array<Float>) : Vec4
    {
        return new Vec4(
            a[0],
            a[1],
            a[2],
            a[3]
        );
    }
    
    @:op(-A)
    public inline function neg() : Vec4
    {
        return new Vec4(
            -x,
            -y,
            -z,
            -w
        );
    }
    
    @:op(A + B)
    public inline function add(B : Vec4) : Vec4
    {
        return new Vec4(
            x + B.x,
            y + B.y,
            z + B.z,
            w + B.w
        );
    }
    
    @:op(A - B)
    public inline function sub(B : Vec4) : Vec4
    {
        return new Vec4(
            x - B.x,
            y - B.y,
            z - B.z,
            w - B.w
        );
    }
    
    @:op(A * B)
    public inline function mul(B : Float) : Vec4
    {
        return new Vec4(
            x * B,
            y * B,
            z * B,
            w * B
        );
    }
    
    @:op(A * B)
    public inline function mulMat4x4(B : Mat4x4) : Vec4
    {
        return new Vec4(
            x * B.xx + y * B.yx + z * B.zx + w * B.wx,
            x * B.xy + y * B.yy + z * B.zy + w * B.wy,
            x * B.xz + y * B.yz + z * B.zz + w * B.wz,
            x * B.xw + y * B.yw + z * B.zw + w * B.ww
        );
    }
    
    @:op(A / B)
    public inline function div(B : Float) : Vec4
    {
        return new Vec4(
            x / B,
            y / B,
            z / B,
            w / B
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
            x / length,
            y / length,
            z / length,
            w / length
        );
    }
}
