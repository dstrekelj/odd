package odd.math;

/**
 * Three-component vector of `Float` types.
 */
private class Vector3 {
    public var x : Float;   public var y : Float;   public var z : Float;
    
    public inline function new(x : Float, y : Float, z : Float) : Void {
        this.x = x; this.y = y; this.z = z;
    }
    
    public inline function toString() : String {
        return '{ x : $x, y : $y, z : $z }';
    }
}

abstract Vec3(Vector3)
{
    public inline function new(x : Float, y : Float, z : Float)
    {
        this = new Vector3(
            x, y, z
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
    
    public var length(get, never) : Float;
    inline function get_length() return Math.sqrt(dot(new Vec3(x, y, z)));
    
    public static inline function fromArray(a : Array<Float>) : Vec3
    {
        return new Vec3(
            a[0],   a[1],   a[2]
        );
    }
    
    @:op(-A)
    public inline function neg() : Vec3
    {
        return new Vec3(
            -x, -y, -z
        );
    }
    
    @:op(A + B)
    public inline function add(B : Vec3) : Vec3
    {
        return new Vec3(
            x + B.x,    y + B.y,    z + B.z
        );
    }
    
    @:op(A - B)
    public inline function sub(B : Vec3) : Vec3
    {
        return new Vec3(
            x - B.x,    y - B.y,    z - B.z
        );
    }
    
    @:op(A * B)
    public inline function mul(B : Float) : Vec3
    {
        return new Vec3(
            x * B,  y * B,  z * B
        );
    }
    
    
    @:op(A / B)
    public inline function div(B : Float) : Vec3
    {
        return new Vec3(
            x / B,  y / B,  z / B
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
            y * B.z - z * B.y,  z * B.x - x * B.z,  x * B.y - y * B.x
        );
    }
    
    @:op(A * B)
    public inline function mulMat4x4(B : Mat4x4) : Vec3
    {
        var v = new Vec4(
            x * B.xx + y * B.yx + z * B.zx + B.wx,  x * B.xy + y * B.yy + z * B.zy + B.wy,  x * B.xz + y * B.yz + z * B.zz + B.wz,  x * B.xw + y * B.yw + z * B.zw + B.ww
        );
        
        if (v.w != 1 && v.w != 0)
        {
            v.x = v.x / v.w;
            v.y = v.y / v.w;
            v.z = v.z / v.w;
        }
        
        return new Vec3(
            v.x,    v.y,    v.z
        );
    }
    
    public inline function normalize() : Vec3
    {
        return new Vec3(
            x / length, y / length, z / length
        );
    }

    public inline function lerp(to : Vec3, factor : Float) : Vec3
    {
        return new Vec3(
            x + (to.x - x) * factor,
            y + (to.y - y) * factor,
            z + (to.z - z) * factor
        );
    }
}
