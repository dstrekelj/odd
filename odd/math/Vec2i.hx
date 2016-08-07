package odd.math;

/**
 * Two-component vector of `Int` types.
 */
abstract Vec2i(Array<Int>)
{
    public inline function new(x : Int, y : Int) this = [x, y];
    
    public var x(get, set) : Int;
    inline function get_x() return this[0];
    inline function set_x(x : Int) return this[0] = x;
    
    public var y(get, set) : Int;
    inline function get_y() return this[1];
    inline function set_y(y : Int) return this[1] = y;
    
    public var length(get, never) : Float;
    inline function get_length() return Math.sqrt(dot(fromArray(this)));
    
    public static inline function fromArray(a : Array<Int>) : Vec2i
    {
        return new Vec2i(
            a[0],
            a[1]
        );
    }
    
    @:op(-A)
    public inline function neg() : Vec2i
    {
        return new Vec2i(
            -x,
            -y
        );
    }

    @:op(A + B)
    public inline function add(B : Vec2i) : Vec2i
    {
        return new Vec2i(
            x + B.x,
            y + B.y
        );
    }

    @:op(A - B)
    public inline function sub(B : Vec2i) : Vec2i
    {
        return new Vec2i(
            x - B.x,
            y - B.y
        );
    }

    @:op(A * B)
    public inline function mul(B : Int) : Vec2i
    {
        return new Vec2i(
            x * B,
            y * B
        );
    }
    
    @:op(A / B)
    public inline function div(B : Int) : Vec2i
    {
        return new Vec2i(
            Std.int(x / B),
            Std.int(y / B)
        );
    }
    
    @:op(A * B)
    public inline function dot(B : Vec2i) : Float
    {
        return x * B.x + y * B.y;
    }
    
    @:op(A % B)
    public inline function cross(B : Vec2i) : Int
    {
        return x * B.y - y * B.x;
    }
}
