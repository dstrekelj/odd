package odd.math;

/**
 * Three-by-three matrix of `Float` types.
 */
private class Matrix3x3 {
    public var xx : Float;  public var xy : Float;  public var xz : Float;
    public var yx : Float;  public var yy : Float;  public var yz : Float;
    public var zx : Float;  public var zy : Float;  public var zz : Float;
    
    public inline function new(
        xx : Float, xy : Float, xz : Float,
        yx : Float, yy : Float, yz : Float,
        zx : Float, zy : Float, zz : Float
    ) : Void {
        this.xx = xx;   this.xy = xy;   this.xz = xz;
        this.yx = yx;   this.yy = yy;   this.yz = yz;
        this.zx = zx;   this.zy = zy;   this.zz = zz;
    }
    
    public inline function toString() : String {
        return '{ { xx : $xx, xy : $xy, xz : $xz }, { yx : $yx, yy : $yy, yz : $yz }, { zx : $zx, zy : $zy, zz : $zz } }';
    }
}

abstract Mat3x3(Matrix3x3)
{
    inline public function new(
        xx : Float, xy : Float, xz : Float,
        yx : Float, yy : Float, yz : Float,
        zx : Float, zy : Float, zz : Float
    )
    {
        this = new Matrix3x3(
            xx, xy, xz,
            yx, yy, yz,
            zx, zy, zz
        );
    }
    
    public var xx(get, set) : Float;
    inline function get_xx() return this.xx;
    inline function set_xx(xx : Float) return this.xx = xx;
    
    public var xy(get, set) : Float;
    inline function get_xy() return this.xy;
    inline function set_xy(xy : Float) return this.xy = xy;
    
    public var xz(get, set) : Float;
    inline function get_xz() return this.xz;
    inline function set_xz(xz : Float) return this.xz = xz;
    
    public var yx(get, set) : Float;
    inline function get_yx() return this.yx;
    inline function set_yx(yx : Float) return this.yx = yx;
    
    public var yy(get, set) : Float;
    inline function get_yy() return this.yy;
    inline function set_yy(yy : Float) return this.yy = yy;
    
    public var yz(get, set) : Float;
    inline function get_yz() return this.yz;
    inline function set_yz(yz : Float) return this.yz = yz;
    
    public var zx(get, set) : Float;
    inline function get_zx() return this.zx;
    inline function set_zx(zx : Float) return this.zx = zx;
    
    public var zy(get, set) : Float;
    inline function get_zy() return this.zy;
    inline function set_zy(zy : Float) return this.zy = zy;
    
    public var zz(get, set) : Float;
    inline function get_zz() return this.zz;
    inline function set_zz(zz : Float) return this.zz = zz;
    
    public static inline function fromArray(a : Array<Float>) : Mat3x3
    {
        return new Mat3x3(
            a[0],   a[1],   a[2],
            a[3],   a[4],   a[5],
            a[6],   a[7],   a[8]
        );
    }
    
    public static inline function identity() : Mat3x3
    {
        return new Mat3x3(
            1, 0, 0,
            0, 1, 0,
            0, 0, 1
        );
    }
    
    public static inline function empty() : Mat3x3
    {
        return new Mat3x3(
            0, 0, 0,
            0, 0, 0,
            0, 0, 0
        );
    }
    
    public static inline function scale(x : Float, y : Float, z : Float) : Mat3x3
    {
        return new Mat3x3(
            x, 0, 0,
            0, y, 0,
            0, 0, z
        );
    }
    
    public static inline function rotateX(a : Float) : Mat3x3
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Mat3x3(
            1,  0,  0
            0,  c,  s
            0, -s,  c
        );
    }

    public static inline function rotateY(a : Float) : Mat3x3
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Mat3x3(
            c,  0, -s,
            0,  1,  0,
            s,  0,  c
        );
    }

    public static inline function rotateZ(a : Float) : Mat3x3
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Mat3x3(
            c,  s,  0,
           -s,  c,  0,
            0,  0,  1
        );
    }

    public static inline function rotate(roll : Float, pitch : Float, yaw : Float) : Mat3x3
    {
        var cx : Float = Math.cos(roll);
        var sx : Float = Math.sin(roll);
        
        var cy : Float = Math.cos(pitch);
        var sy : Float = Math.sin(pitch);
        
        var cz : Float = Math.cos(yaw);
        var sz : Float = Math.sin(yaw);
        
        return new Mat3x3(
            cz * cy,                    sz * sy,                   -sy,
            cz * sy * sx - sz * cx,     sz * sy * sx + cz * cx,     cy * sx,
            cz * sy * cx + sz * sx,     sz * sy * cx - cz * sx,     cy * cx
        );
    }
    
    @:op(-A)
    public inline function neg() : Mat3x3
    {
        return new Mat3x3(
          -xx, -xy, -xz,
          -yx, -yy, -yz,
          -zx, -zy, -zz
        );
    }

    @:op(A + B)
    public inline function add(B : Mat3x3) : Mat3x3
    {
        return new Mat3x3(
          xx + B.xx,    xy + B.xy,    xz + B.xz,
          yx + B.yx,    yy + B.yy,    yz + B.yz,
          zx + B.zx,    zy + B.zy,    zz + B.zz
        );
    }

    @:op(A - B)
    public inline function sub(B : Mat3x3) : Mat3x3
    {
        return new Mat3x3(
          xx - B.xx,    xy - B.xy,    xz - B.xz,
          yx - B.yx,    yy - B.yy,    yz - B.yz,
          zx - B.zx,    zy - B.zy,    zz - B.zz
        );
    }

    @:op(A * B)
    public inline function mul(B : Float) : Mat3x3
    {
        return new Mat3x3(
          xx * B,   xy * B,   xz * B,
          yx * B,   yy * B,   yz * B,
          zx * B,   zy * B,   zz * B
        );
    }

    @:op(A * B)
    public inline function mulMat3x3(B : Mat3x3) : Mat3x3
    {
        return new Mat3x3(
          xx * B.xx + xy * B.yx + xz * B.zx,    xx * B.xy + xy * B.yy + xz * B.zy,    xx * B.xz + xy * B.yz + xz * B.zz,
          yx * B.xx + yy * B.yx + yz * B.zx,    yx * B.xy + yy * B.yy + yz * B.zy,    yx * B.xz + yy * B.yz + yz * B.zz,
          zx * B.xx + zy * B.yx + zz * B.zx,    zx * B.xy + zy * B.yy + zz * B.zy,    zx * B.xz + zy * B.yz + zz * B.zz
        );
    }
}
