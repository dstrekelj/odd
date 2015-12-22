package odd.math;

class Vec4
{
    public var x : Float;
    public var y : Float;
    public var z : Float;
    public var w : Float;

    public function new(?x : Float = 0, ?y : Float = 0, ?z : Float = 0, ?w : Float = 1)
    {
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
    }

    public function toString() : String
    {
        return '{ $x, $y, $z, $w }';
    }
}

@:forward(x, y, z, w)
abstract Vector4(Vec4) from Vec4 to Vec4
{
    public var length(get, never) : Float;

    inline function get_length() : Float
    {
        return Math.sqrt(dotProduct(this));
    }
    
    inline public function new(?x : Float, ?y : Float, ?z : Float, ?w : Float)
    {
        this = new Vec4(
            x,
            y,
            z,
            w
        );
    }

    @:op(-A)
    inline function negate() : Vector4
    {
        return new Vector4(
            -this.x,
            -this.y,
            -this.z,
            -this.w
        );
    }

    @:op(A + B)
    inline function add(B : Vector4) : Vector4
    {
        return new Vector4(
            this.x + B.x,
            this.y + B.y,
            this.z + B.z,
            this.w + B.w
        );
    }

    @:op(A - B)
    inline function subtract(B : Vector4) : Vector4
    {
        return new Vector4(
            this.x - B.x,
            this.y - B.y,
            this.z - B.z,
            this.w - B.w
        );
    }

    @:op(A * B)
    inline function multiply(B : Float) : Vector4
    {
        return new Vector4(
            this.x * B,
            this.y * B,
            this.z * B,
            this.w * B
        );
    }
    
    @:op(A / B)
    inline function divide(B : Float) : Vector4
    {
        return new Vector4(
            this.x / B,
            this.y / B,
            this.z / B,
            this.w / B
        );
    }

    @:op(A * B)
    inline function dotProduct(B : Vector4) : Float
    {
        return this.x * B.x + this.y * B.y + this.z * B.z + this.w * B.w;
    }
    
    public inline function normalize() : Vector4
    {
        return new Vector4(
            this.x / length,
            this.y / length,
            this.z / length,
            this.w / length
        );
    }
}