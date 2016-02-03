package odd.math;

abstract OddVec2(Array<Float>)
{
    public inline function new(x : Float = null, y : Float = null)
    {
        this = [x, y];
    }
    
    public var x(get, set) : Float;
    inline function get_x() : Float { return this[0]; }
    inline function set_x(x : Float) : Float { this[0] = x; return this[0]; }
    
    public var y(get, set) : Float;
    inline function get_y() : Float { return this[1]; }
    inline function set_y(y : Float) : Float { this[1] = y; return this[1]; }
    
    public var length(get, never) : Float;
    inline function get_length() : Float { return Math.sqrt(dotProduct(fromArray(this))); }
    
    public static inline function fromArray(a : Array<Float>) : OddVec2
    {
        return new OddVec2(
            a[0],
            a[1]
        );
    }
    
    @:op(-A)
    public inline function negate() : OddVec2
    {
        return new OddVec2(
            -x,
            -y
        );
    }

    @:op(A + B)
    public inline function add(B : OddVec2) : OddVec2
    {
        return new OddVec2(
            x + B.x,
            y + B.y
        );
    }

    @:op(A - B)
    public inline function subtract(B : OddVec2) : OddVec2
    {
        return new OddVec2(
            x - B.x,
            y - B.y
        );
    }

    @:op(A * B)
    public inline function multiplyScalar(B : Float) : OddVec2
    {
        return new OddVec2(
            x * B,
            y * B
        );
    }
    
    @:op(A / B)
    public inline function divideScalar(B : Float) : OddVec2
    {
        return new OddVec2(
            x / B,
            y / B
        );
    }
    
    @:op(A * B)
    public inline function dotProduct(B : OddVec2) : Float
    {
        return x * B.x + y * B.y;
    }
    
    @:op(A % B)
    public inline function crossProduct(B : OddVec2) : Float
    {
        return x * B.y - y * B.x;
    }
    
    public inline function normalize() : OddVec2
    {
        return new OddVec2(
            x / length,
            y / length
        );
    }
}