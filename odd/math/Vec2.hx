package odd.math;

/**
 * Two-component vector of `Float` types.
 */
private class Vector2 {
    public var x : Float;   public var y : Float;
    
    public inline function new(x : Float, y : Float) : Void {
        this.x = x; this.y = y;
    }
    
    public inline function toString() : String {
        return '{ x : $x, y : $y }';
    }
}

abstract Vec2(Vector2)
{
    public inline function new(x : Float, y : Float)
    {
        this = new Vector2(
            x,  y
        );
    }
    
    public var x(get, set) : Float;
    inline function get_x() return this.x;
    inline function set_x(x : Float) return this.x = x;
    
    public var y(get, set) : Float;
    inline function get_y() return this.y;
    inline function set_y(y : Float) return this.y = y;
    
    public var length(get, never) : Float;
    inline function get_length() return Math.sqrt(dot(new Vec2(x, y)));
    
    public static inline function fromArray(a : Array<Float>) : Vec2
    {
        return new Vec2(
            a[0],   a[1]
        );
    }
    
    @:op(-A)
    public inline function neg() : Vec2
    {
        return new Vec2(
            -x, -y
        );
    }

    @:op(A + B)
    public inline function add(B : Vec2) : Vec2
    {
        return new Vec2(
            x + B.x,    y + B.y
        );
    }

    @:op(A - B)
    public inline function sub(B : Vec2) : Vec2
    {
        return new Vec2(
            x - B.x,    y - B.y
        );
    }

    @:op(A * B)
    public inline function mul(B : Float) : Vec2
    {
        return new Vec2(
            x * B,  y * B
        );
    }
    
    @:op(A / B)
    public inline function div(B : Float) : Vec2
    {
        return new Vec2(
            x / B,  y / B
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
            x / length, y / length
        );
    }

    public inline function lerp(to : Vec2, factor : Float) : Vec2
    {
        return new Vec2(
            x + (to.x - x) * factor,
            y + (to.y - y) * factor
        );
    }
}
