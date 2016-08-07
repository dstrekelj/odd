package odd.math;

/**
 * Two-component vector of `Float` types.
 */
abstract Vec2(Array<Float>)
{
    public inline function new(x : Float, y : Float) this = [x, y];
    
    public var x(get, set) : Float;
    inline function get_x() return this[0];
    inline function set_x(x : Float) return this[0] = x;
    
    public var y(get, set) : Float;
    inline function get_y() return this[1];
    inline function set_y(y : Float) return this[1] = y;
    
    public var length(get, never) : Float;
    inline function get_length() return Math.sqrt(dot(fromArray(this)));
    
    public static inline function fromArray(a : Array<Float>) : Vec2
    {
        return new Vec2(
            a[0],
            a[1]
        );
    }
    
    @:op(-A)
    public inline function neg() : Vec2
    {
        return new Vec2(
            -x,
            -y
        );
    }

    @:op(A + B)
    public inline function add(B : Vec2) : Vec2
    {
        return new Vec2(
            x + B.x,
            y + B.y
        );
    }

    @:op(A - B)
    public inline function sub(B : Vec2) : Vec2
    {
        return new Vec2(
            x - B.x,
            y - B.y
        );
    }

    @:op(A * B)
    public inline function mul(B : Float) : Vec2
    {
        return new Vec2(
            x * B,
            y * B
        );
    }
    
    @:op(A / B)
    public inline function div(B : Float) : Vec2
    {
        return new Vec2(
            x / B,
            y / B
        );
    }
    
    @:op(A * B)
    public inline function dot(B : Vec2) : Float
    {
        return x * B.x + y * B.y;
    }
    
    @:op(A % B)
    public inline function cross(B : Vec2) : Float
    {
        return x * B.y - y * B.x;
    }
    
    public inline function normalize() : Vec2
    {
        return new Vec2(
            x / length,
            y / length
        );
    }
}
