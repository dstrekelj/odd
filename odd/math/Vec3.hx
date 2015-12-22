package odd.math;

class Vec3
{
    public var x : Float;
    public var y : Float;
    public var z : Float;

    public function new(?x : Float = 0, ?y : Float = 0, ?z : Float = 0)
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public function toString() : String
    {
        return '{ $x, $y, $z }';
    }
}

@:forward(x, y, z)
abstract Vector3(Vec3) from Vec3 to Vec3
{
    public var length(get, never) : Float;

    inline function get_length() : Float
    {
        return Math.sqrt(dotProduct(this));
    }
    
    inline public function new(?x : Float, ?y : Float, ?z : Float)
    {
        this = new Vec3(
            x,
            y,
            z
        );
    }

    @:op(-A)
    inline function negate() : Vector3
    {
        return new Vector3(
            -this.x,
            -this.y,
            -this.z
        );
    }

    @:op(A + B)
    inline function add(B : Vector3) : Vector3
    {
        return new Vector3(
            this.x + B.x,
            this.y + B.y,
            this.z + B.z
        );
    }

    @:op(A - B)
    inline function subtract(B : Vector3) : Vector3
    {
        return new Vector3(
            this.x - B.x,
            this.y - B.y,
            this.z - B.z
        );
    }

    @:op(A * B)
    inline function multiply(B : Float) : Vector3
    {
        return new Vector3(
            this.x * B,
            this.y * B,
            this.z * B
        );
    }
    
    @:op(A / B)
    inline function divide(B : Float) : Vector3
    {
        return new Vector3(
            this.x / B,
            this.y / B,
            this.z / B
        );
    }

    @:op(A * B)
    inline function dotProduct(B : Vector3) : Float
    {
        return this.x * B.x + this.y * B.y + this.z * B.z;
    }
    
    @:op(A % B)
    inline function crossProduct(B : Vector3) : Vector3
    {
        return new Vector3(
            this.y * B.z - this.z * B.y,
            this.z * B.x - this.x * B.z,
            this.x * B.y - this.y * B.x
        );
    }
    
    public inline function normalize() : Vector3
    {
        return new Vector3(
            this.x / length,
            this.y / length,
            this.z / length
        );
    }
}