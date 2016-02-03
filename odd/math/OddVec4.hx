package odd.math;

abstract OddVec4(Array<Float>)
{
    inline public function new(x : Float = null, y : Float = null, z : Float = null, w : Float = null)
    {
        this = [x, y, z, w];
    }
    
    public var x(get, set) : Float;
    inline function get_x() : Float { return this[0]; }
    inline function set_x(x : Float) : Float { this[0] = x; return this[0]; }
    
    public var y(get, set) : Float;
    inline function get_y() : Float { return this[1]; }
    inline function set_y(y : Float) : Float { this[1] = y; return this[1]; }
    
    public var z(get, set) : Float;
    inline function get_z() : Float { return this[2]; }
    inline function set_z(z : Float) : Float { this[2] = z; return this[2]; }
    
    public var w(get, set) : Float;
    inline function get_w() : Float { return this[3]; }
    inline function set_w(w : Float) : Float { this[3] = w; return this[3]; }
    
    public var length(get, never) : Float;
    inline function get_length() : Float { return Math.sqrt(dotProduct(fromArray(this))); }
    
    public static inline function fromArray(a : Array<Float>) : OddVec4
    {
        return new OddVec4(
            a[0],
            a[1],
            a[2],
            a[3]
        );
    }
    
    @:op( -A)
    public inline function negate() : OddVec4
    {
        return new OddVec4(
            -x,
            -y,
            -z,
            -w
        );
    }
    
    @:op(A + B)
    public inline function add(B : OddVec4) : OddVec4
    {
        return new OddVec4(
            x + B.x,
            y + B.y,
            z + B.z,
            w + B.w
        );
    }
    
    @:op(A - B)
    public inline function subtract(B : OddVec4) : OddVec4
    {
        return new OddVec4(
            x - B.x,
            y - B.y,
            z - B.z,
            w - B.w
        );
    }
    
    @:op(A * B)
    public inline function multiplyScalar(B : Float) : OddVec4
    {
        return new OddVec4(
            x * B,
            y * B,
            z * B,
            w * B
        );
    }
    
    @:op(A * B)
    public inline function multiplyMat4(B : OddMat4) : OddVec4
    {
        return new OddVec4(
            x * B.xx + y * B.yx + z * B.zx + w * B.wx,
            x * B.xy + y * B.yy + z * B.zy + w * B.wy,
            x * B.xz + y * B.yz + z * B.zz + w * B.wz,
            x * B.xw + y * B.yw + z * B.zw + w * B.ww
        );
    }
    
    @:op(A / B)
    public inline function divideScalar(B : Float) : OddVec4
    {
        return new OddVec4(
            x / B,
            y / B,
            z / B,
            w / B
        );
    }
    
    @:op(A * B)
    public inline function dotProduct(B : OddVec4) : Float
    {
        return x * B.x + y * B.y + z * B.z + w * B.w;
    }
    
    public inline function normalize() : OddVec4
    {
        return new OddVec4(
            x / length,
            y / length,
            z / length,
            w / length
        );
    }
}