package odd.math;

abstract OddVec3(Array<Float>)
{
    public inline function new(x : Float = null, y : Float = null, z : Float = null)
    {
        this = [x, y, z];
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
    
    public var length(get, never) : Float;
    inline function get_length() : Float { return Math.sqrt(dotProduct(fromArray(this))); }
    
    public static inline function fromArray(a : Array<Float>) : OddVec3
    {
        return new OddVec3(
            a[0],
            a[1],
            a[2]
        );
    }
    
	public static inline function fromDelimitiredString(s : String, d : String) : OddVec3
	{
		var components : Array<String> = s.split(d);
		return new OddVec3(
			Std.parseFloat(components[0]),
			Std.parseFloat(components[1]),
			Std.parseFloat(components[2])
		);
	}
	
    @:op( -A)
    public inline function negate() : OddVec3
    {
        return new OddVec3(
            -x,
            -y,
            -z
        );
    }
    
    @:op(A + B)
    public inline function add(B : OddVec3) : OddVec3
    {
        return new OddVec3(
            x + B.x,
            y + B.y,
            z + B.z
        );
    }
    
    @:op(A - B)
    public inline function subtract(B : OddVec3) : OddVec3
    {
        return new OddVec3(
            x - B.x,
            y - B.y,
            z - B.z
        );
    }
    
    @:op(A * B)
    public inline function multiplyScalar(B : Float) : OddVec3
    {
        return new OddVec3(
            x * B,
            y * B,
            z * B
        );
    }
    
    
    @:op(A / B)
    public inline function divideScalar(B : Float) : OddVec3
    {
        return new OddVec3(
            x / B,
            y / B,
            z / B
        );
    }
    
    @:op(A * B)
    public inline function dotProduct(B : OddVec3) : Float
    {
        return x * B.x + y * B.y + z * B.z;
    }
    
    @:op(A % B)
    public inline function crossProduct(B : OddVec3) :  OddVec3
    {
        return new OddVec3(
            y * B.z - z * B.y,
            z * B.x - x * B.z,
            x * B.y - y * B.x
        );
    }
    
    @:op(A * B)
    public inline function multiplyMat4(B : OddMat4) : OddVec3
    {
        var v = new OddVec4(
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
        
        return new OddVec3(
            v.x,
            v.y,
            v.z
        );
    }
    
    public inline function normalize() : OddVec3
    {
        return new OddVec3(
            x / length,
            y / length,
            z / length
        );
    }
}