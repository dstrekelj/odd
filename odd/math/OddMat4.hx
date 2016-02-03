package odd.math;

abstract OddMat4(Array<Float>)
{
    inline public function new(
        xx : Float = null, xy : Float = null, xz : Float = null, xw : Float = null,
        yx : Float = null, yy : Float = null, yz : Float = null, yw : Float = null,
        zx : Float = null, zy : Float = null, zz : Float = null, zw : Float = null,
        wx : Float = null, wy : Float = null, wz : Float = null, ww : Float = null
    )
    {
        this = [
            xx, xy, xz, xw,
            yx, yy, yz, yw,
            zx, zy, zz, zw,
            wx, wy, wz, ww
        ];
    }
    
    public var xx(get, set) : Float;
    inline function get_xx() : Float { return this[0]; }
    inline function set_xx(xx : Float) : Float { this[0] = xx; return this[0]; }
    
    public var xy(get, set) : Float;
    inline function get_xy() : Float { return this[1]; }
    inline function set_xy(xy : Float) : Float { this[1] = xy; return this[1]; }
    
    public var xz(get, set) : Float;
    inline function get_xz() : Float { return this[2]; }
    inline function set_xz(xz : Float) : Float { this[2] = xz; return this[2]; }
    
    public var xw(get, set) : Float;
    inline function get_xw() : Float { return this[3]; }
    inline function set_xw(xw : Float) : Float { this[3] = xw; return this[3]; }
    
    public var yx(get, set) : Float;
    inline function get_yx() : Float { return this[4]; }
    inline function set_yx(yx : Float) : Float { this[4] = yx; return this[4]; }
    
    public var yy(get, set) : Float;
    inline function get_yy() : Float { return this[5]; }
    inline function set_yy(yy : Float) : Float { this[5] = yy; return this[5]; }
    
    public var yz(get, set) : Float;
    inline function get_yz() : Float { return this[6]; }
    inline function set_yz(yz : Float) : Float { this[6] = yz; return this[6]; }
    
    public var yw(get, set) : Float;
    inline function get_yw() : Float { return this[7]; }
    inline function set_yw(yw : Float) : Float { this[7] = yw; return this[7]; }
    
    public var zx(get, set) : Float;
    inline function get_zx() : Float { return this[8]; }
    inline function set_zx(zx : Float) : Float { this[8] = zx; return this[8]; }
    
    public var zy(get, set) : Float;
    inline function get_zy() : Float { return this[9]; }
    inline function set_zy(zy : Float) : Float { this[9] = zy; return this[9]; }
    
    public var zz(get, set) : Float;
    inline function get_zz() : Float { return this[10]; }
    inline function set_zz(zz : Float) : Float { this[10] = zz; return this[10]; }
    
    public var zw(get, set) : Float;
    inline function get_zw() : Float { return this[11]; }
    inline function set_zw(zw : Float) : Float { this[11] = zw; return this[11]; }
    
    public var wx(get, set) : Float;
    inline function get_wx() : Float { return this[12]; }
    inline function set_wx(wx : Float) : Float { this[12] = wx; return this[12]; }
    
    public var wy(get, set) : Float;
    inline function get_wy() : Float { return this[13]; }
    inline function set_wy(wy : Float) : Float { this[13] = wy; return this[13]; }
    
    public var wz(get, set) : Float;
    inline function get_wz() : Float { return this[14]; }
    inline function set_wz(wz : Float) : Float { this[14] = wz; return this[14]; }
    
    public var ww(get, set) : Float;
    inline function get_ww() : Float { return this[15]; }
    inline function set_ww(ww : Float) : Float { this[15] = ww; return this[15]; }
    
    public static inline function fromArray(a : Array<Float>) : OddMat4
    {
        return new OddMat4(
            a[0],   a[1],   a[2],   a[3],
            a[4],   a[5],   a[6],   a[7],
            a[8],   a[9],   a[10],  a[11],
            a[12],  a[13],  a[14],  a[15]
        );
    }
    
    public static inline function identity() : OddMat4
    {
        return new OddMat4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1
        );
    }
    
    public static inline function empty() : OddMat4
    {
        return new OddMat4(
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        );
    }
    
    public static inline function translate(x : Float, y : Float, z : Float) : OddMat4
    {
        return new OddMat4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            x, y, z, 1
        );
    }
    
    public static inline function scale(x : Float, y : Float, z : Float) : OddMat4
    {
        return new OddMat4(
            x, 0, 0, 0,
            0, y, 0, 0,
            0, 0, z, 0,
            0, 0, 0, 1
        );
    }
    
    public static function rotateX(a : Float) : OddMat4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new OddMat4(
            1,  0,  0,  0,
            0,  c,  s,  0,
            0, -s,  c,  0,
            0,  0,  0,  1
        );
    }

    public static function rotateY(a : Float) : OddMat4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new OddMat4(
            c,  0, -s,  0,
            0,  1,  0,  0,
            s,  0,  c,  0,
            0,  0,  0,  1
        );
    }

    public static function rotateZ(a : Float) : OddMat4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new OddMat4(
            c,  s,  0,  0,
           -s,  c,  0,  0,
            0,  0,  1,  0,
            0,  0,  0,  1
        );
    }

    public static function rotate(roll : Float, pitch : Float, yaw : Float) : OddMat4
    {
        var cx : Float = Math.cos(roll);
        var sx : Float = Math.sin(roll);
        
        var cy : Float = Math.cos(pitch);
        var sy : Float = Math.sin(pitch);
        
        var cz : Float = Math.cos(yaw);
        var sz : Float = Math.sin(yaw);
        
        return new OddMat4(
            cz * cy,                    sz * sy,                   -sy,         0,
            cz * sy * sx - sz * cx,     sz * sy * sx + cz * cx,     cy * sx,    0,
            cz * sy * cx + sz * sx,     sz * sy * cx - cz * sx,     cy * cx,    0,
            0,                          0,                          0,          1
        );
    }
    
    @:op(-A)
    public inline function negate() : OddMat4
    {
        return new OddMat4(
          -xx, -xy, -xz, -xw,
          -yx, -yy, -yz, -yw,
          -zx, -zy, -zz, -zw,
          -wx, -wy, -wz, -ww
        );
    }

    @:op(A + B)
    public inline function add(B : OddMat4) : OddMat4
    {
        return new OddMat4(
          xx + B.xx,    xy + B.xy,    xz + B.xz,    xw + B.xw,
          yx + B.yx,    yy + B.yy,    yz + B.yz,    yw + B.yw,
          zx + B.zx,    zy + B.zy,    zz + B.zz,    zw + B.zw,
          wx + B.wx,    wy + B.wy,    wz + B.wz,    ww + B.ww
        );
    }

    @:op(A - B)
    public inline function subtract(B : OddMat4) : OddMat4
    {
        return new OddMat4(
          xx - B.xx,    xy - B.xy,    xz - B.xz,    xw - B.xw,
          yx - B.yx,    yy - B.yy,    yz - B.yz,    yw - B.yw,
          zx - B.zx,    zy - B.zy,    zz - B.zz,    zw - B.zw,
          wx - B.wx,    wy - B.wy,    wz - B.wz,    ww - B.ww
        );
    }

    @:op(A * B)
    public inline function multiplyScalar(B : Float) : OddMat4
    {
        return new OddMat4(
          xx * B,   xy * B,   xz * B,   xw * B,
          yx * B,   yy * B,   yz * B,   yw * B,
          zx * B,   zy * B,   zz * B,   zw * B,
          wx * B,   wy * B,   wz * B,   ww * B
        );
    }

    @:op(A * B)
    public inline function multiplyMatrix(B : OddMat4) : OddMat4
    {
        return new OddMat4(
          xx * B.xx + xy * B.yx + xz * B.zx + xw * B.wx,    xx * B.xy + xy * B.yy + xz * B.zy + xw * B.wy,    xx * B.xz + xy * B.yz + xz * B.zz + xw * B.wz,    xx * B.xw + xy * B.yw + xz * B.zw + xw * B.ww,
          yx * B.xx + yy * B.yx + yz * B.zx + yw * B.wx,    yx * B.xy + yy * B.yy + yz * B.zy + yw * B.wy,    yx * B.xz + yy * B.yz + yz * B.zz + yw * B.wz,    yx * B.xw + yy * B.yw + yz * B.zw + yw * B.ww,
          zx * B.xx + zy * B.yx + zz * B.zx + zw * B.wx,    zx * B.xy + zy * B.yy + zz * B.zy + zw * B.wy,    zx * B.xz + zy * B.yz + zz * B.zz + zw * B.wz,    zx * B.xw + zy * B.yw + zz * B.zw + zw * B.ww,
          wx * B.xx + wy * B.yx + wz * B.zx + ww * B.wx,    wx * B.xy + wy * B.yy + wz * B.zy + ww * B.wy,    wx * B.xz + wy * B.yz + wz * B.zz + ww * B.wz,    wx * B.xw + wy * B.yw + wz * B.zw + ww * B.ww
        );
    }
}