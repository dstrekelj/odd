package odd.math;

class Vec2
{
    public var x : Float;
    public var y : Float;
    
    public function new(?x : Float = 0, ?y : Float = 0)
    {
        this.x = x;
        this.y = y;
    }
    
    public function toString() : String
    {
        return '{ $x, $y }';
    }
}

abstract Vector2(Vec2) from Vec2 to Vec2
{
    public var length(get, never) : Float;
    
    inline function get_length() : Float
    {
        return Math.sqrt(dotProduct(this));
    }
    
    inline public function new(?x : Float, ?y : Float)
    {
        this = new Vec2(
            x,
            y
        );
    }
    
    @:op(-A)
    inline function negate() : Vector2
    {
        return new Vector2(
            -this.x,
            -this.y
        );
    }

    @:op(A + B)
    inline function add(B : Vector2) : Vector2
    {
        return new Vector2(
            this.x + B.x,
            this.y + B.y
        );
    }

    @:op(A - B)
    inline function subtract(B : Vector2) : Vector2
    {
        return new Vector2(
            this.x - B.x,
            this.y - B.y
        );
    }

    @:op(A * B)
    inline function multiplyScalar(B : Float) : Vector2
    {
        return new Vector2(
            this.x * B,
            this.y * B
        );
    }
    
     @:op(A / B)
    inline function divide(B : Float) : Vector2
    {
        return new Vector2(
            this.x / B,
            this.y / B
        );
    }
    
    @:op(A * B)
    inline function dotProduct(B : Vector2) : Float
    {
        return this.x * B.x + this.y * B.y;
    }
    
    @:op(A * B)
    inline function crossProduct(B : Vector2) : Float
    {
        return this.x * B.y - this.y * B.x;
    }
}