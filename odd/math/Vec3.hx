package odd.math;

/**
 * Three-component vector of `Float` types.
 */
abstract Vec3(Array<Float>)
{
    public inline function new(x : Float, y : Float, z : Float) this = [x, y, z];
    
    public var x(get, set) : Float;
    inline function get_x() return this[0];
    inline function set_x(x : Float) return this[0] = x;
    
    public var y(get, set) : Float;
    inline function get_y() return this[1];
    inline function set_y(y : Float) return this[1] = y;
    
    public var z(get, set) : Float;
    inline function get_z() return this[2];
    inline function set_z(z : Float) return this[2] = z;
    
    public var length(get, never) : Float;
    inline function get_length() return Math.sqrt(dot(fromArray(this)));
    
    public static inline function fromArray(a : Array<Float>) : Vec3
    {
        return new Vec3(
            a[0],
            a[1],
            a[2]
        );
    }
    
    @:op(-A)
    public inline function neg() : Vec3
    {
        return new Vec3(
            -x,
            -y,
            -z
        );
    }
    
    @:op(A + B)
    public inline function add(B : Vec3) : Vec3
    {
        return new Vec3(
            x + B.x,
            y + B.y,
            z + B.z
        );
    }
    
    @:op(A - B)
    public inline function sub(B : Vec3) : Vec3
    {
        return new Vec3(
            x - B.x,
            y - B.y,
            z - B.z
        );
    }
    
    @:op(A * B)
    public inline function mul(B : Float) : Vec3
    {
        return new Vec3(
            x * B,
            y * B,
            z * B
        );
    }
    
    
    @:op(A / B)
    public inline function div(B : Float) : Vec3
    {
        return new Vec3(
            x / B,
            y / B,
            z / B
        );
    }
    
    @:op(A * B)
    public inline function dot(B : Vec3) : Float
    {
        return x * B.x + y * B.y + z * B.z;
    }
    
    @:op(A % B)
    public inline function cross(B : Vec3) :  Vec3
    {
        return new Vec3(
            y * B.z - z * B.y,
            z * B.x - x * B.z,
            x * B.y - y * B.x
        );
    }
    
    @:op(A * B)
    public inline function mulMat4x4(B : Mat4x4) : Vec3
    {
        var v = new Vec4(
            x * B.xx + y * B.yx + z * B.zx + B.wx,
            x * B.xy + y * B.yy + z * B.zy + B.wy,
            x * B.xz + y * B.yz + z * B.zz + B.wz,
            x * B.xw + y * B.yw + z * B.zw + B.ww
        );
        
        if (v.w != 1 && v.w != 0)
        {
            v.x = v.x / v.w;
            v.y = v.y / v.w;
            v.z = v.z / v.w;
        }
        
        return new Vec3(
            v.x,
            v.y,
            v.z
        );
    }
    
    public inline function normalize() : Vec3
    {
        return new Vec3(
            x / length,
            y / length,
            z / length
        );
    }
}
