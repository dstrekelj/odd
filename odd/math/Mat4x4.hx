package odd.math;

/**
 * Four-by-four matrix of `Float` types.
 */
private class Matrix4x4 {
    public var xx : Float;  public var xy : Float;  public var xz : Float;  public var xw : Float;
    public var yx : Float;  public var yy : Float;  public var yz : Float;  public var yw : Float;
    public var zx : Float;  public var zy : Float;  public var zz : Float;  public var zw : Float;
    public var wx : Float;  public var wy : Float;  public var wz : Float;  public var ww : Float;
    
    public inline function new(
        xx : Float, xy : Float, xz : Float, xw : Float,
        yx : Float, yy : Float, yz : Float, yw : Float,
        zx : Float, zy : Float, zz : Float, zw : Float,
        wx : Float, wy : Float, wz : Float, ww : Float
    ) : Void {
        this.xx = xx;   this.xy = xy;   this.xz = xz;   this.xw = xw;
        this.yx = yx;   this.yy = yy;   this.yz = yz;   this.yw = yw;
        this.zx = zx;   this.zy = zy;   this.zz = zz;   this.zw = zw;
        this.wx = wx;   this.wy = wy;   this.wz = wz;   this.ww = ww;
    }
    
    public inline function toString() : String {
        return '{ { xx : $xx, xy : $xy, xz : $xz, xw : $xw }, { yx : $yx, yy : $yy, yz : $yz, yw : $yw }, { zx : $zx, zy : $zy, zz : $zz, zw : $zw }, { wx : $wx, wy : $wy, wz : $wz, ww : $ww } }';
    }
}

abstract Mat4x4(Matrix4x4)
{
    inline public function new(
        xx : Float, xy : Float, xz : Float, xw : Float,
        yx : Float, yy : Float, yz : Float, yw : Float,
        zx : Float, zy : Float, zz : Float, zw : Float,
        wx : Float, wy : Float, wz : Float, ww : Float
    )
    {
        this = new Matrix4x4(
            xx, xy, xz, xw,
            yx, yy, yz, yw,
            zx, zy, zz, zw,
            wx, wy, wz, ww
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
    
    public var xw(get, set) : Float;
    inline function get_xw() return this.xw;
    inline function set_xw(xw : Float) return this.xw = xw;
    
    public var yx(get, set) : Float;
    inline function get_yx() return this.yx;
    inline function set_yx(yx : Float) return this.yx = yx;
    
    public var yy(get, set) : Float;
    inline function get_yy() return this.yy;
    inline function set_yy(yy : Float) return this.yy = yy;
    
    public var yz(get, set) : Float;
    inline function get_yz() return this.yz;
    inline function set_yz(yz : Float) return this.yz = yz;
    
    public var yw(get, set) : Float;
    inline function get_yw() return this.yw;
    inline function set_yw(yw : Float) return this.yw = yw;
    
    public var zx(get, set) : Float;
    inline function get_zx() return this.zx;
    inline function set_zx(zx : Float) return this.zx = zx;
    
    public var zy(get, set) : Float;
    inline function get_zy() return this.zy;
    inline function set_zy(zy : Float) return this.zy = zy;
    
    public var zz(get, set) : Float;
    inline function get_zz() return this.zz;
    inline function set_zz(zz : Float) return this.zz = zz;
    
    public var zw(get, set) : Float;
    inline function get_zw() return this.zw;
    inline function set_zw(zw : Float) return this.zw = zw;
    
    public var wx(get, set) : Float;
    inline function get_wx() return this.wx;
    inline function set_wx(wx : Float) return this.wx = wx;
    
    public var wy(get, set) : Float;
    inline function get_wy() return this.wy;
    inline function set_wy(wy : Float) return this.wy = wy;
    
    public var wz(get, set) : Float;
    inline function get_wz() return this.wz;
    inline function set_wz(wz : Float) return this.wz = wz;
    
    public var ww(get, set) : Float;
    inline function get_ww() return this.ww;
    inline function set_ww(ww : Float) return this.ww = ww;
    
    public static inline function fromArray(a : Array<Float>) : Mat4x4
    {
        return new Mat4x4(
            a[0],   a[1],   a[2],   a[3],
            a[4],   a[5],   a[6],   a[7],
            a[8],   a[9],   a[10],  a[11],
            a[12],  a[13],  a[14],  a[15]
        );
    }
    
    public static inline function identity() : Mat4x4
    {
        return new Mat4x4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1
        );
    }
    
    public static inline function empty() : Mat4x4
    {
        return new Mat4x4(
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        );
    }
    
    public static inline function translate(x : Float, y : Float, z : Float) : Mat4x4
    {
        return new Mat4x4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            x, y, z, 1
        );
    }
    
    public static inline function scale(x : Float, y : Float, z : Float) : Mat4x4
    {
        return new Mat4x4(
            x, 0, 0, 0,
            0, y, 0, 0,
            0, 0, z, 0,
            0, 0, 0, 1
        );
    }
    
    public static inline function rotateX(a : Float) : Mat4x4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Mat4x4(
            1,  0,  0,  0,
            0,  c,  s,  0,
            0, -s,  c,  0,
            0,  0,  0,  1
        );
    }

    public static inline function rotateY(a : Float) : Mat4x4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Mat4x4(
            c,  0, -s,  0,
            0,  1,  0,  0,
            s,  0,  c,  0,
            0,  0,  0,  1
        );
    }

    public static inline function rotateZ(a : Float) : Mat4x4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Mat4x4(
            c,  s,  0,  0,
           -s,  c,  0,  0,
            0,  0,  1,  0,
            0,  0,  0,  1
        );
    }

    public static inline function rotate(roll : Float, pitch : Float, yaw : Float) : Mat4x4
    {
        var cx : Float = Math.cos(roll);
        var sx : Float = Math.sin(roll);
        
        var cy : Float = Math.cos(pitch);
        var sy : Float = Math.sin(pitch);
        
        var cz : Float = Math.cos(yaw);
        var sz : Float = Math.sin(yaw);
        
        return new Mat4x4(
            cz * cy,                    sz * sy,                   -sy,         0,
            cz * sy * sx - sz * cx,     sz * sy * sx + cz * cx,     cy * sx,    0,
            cz * sy * cx + sz * sx,     sz * sy * cx - cz * sx,     cy * cx,    0,
            0,                          0,                          0,          1
        );
    }
    
    public static inline function perspective(fovY : Float, aspectRatio : Float, n : Float, f : Float) : Mat4x4
    {
        var t : Float = Math.tan(fovY / 2) * n;
        var b : Float = -t;
        var r : Float = t * aspectRatio;
        var l : Float = -r;
        
        return new Mat4x4(
            (2 * n) / (r - l),  0,                  0,                      0,
            0,                  (2 * n) / (t - b),  0,                      0,
           -(r + l) / (r - l), -(t + b) / (t - b),  f / (n - f),           -1,
            0,                  0,                  (n * f) / (n - f),      0
        );
    }
    
    public static inline function orthographic(r : Float, l : Float, t : Float, b : Float, n : Float, f : Float) : Mat4x4
    {
        return new Mat4x4(
            2 / (r - l),        0,                  0,                  0,
            0,                  2 / (t - b),        0,                  0,
            0,                  0,                  1 / (n - f),        0,
           -(r + l) / (r - l), -(t + b) / (t - b),  n / (n - f),        1
        );
    }
    
    @:op(-A)
    public inline function neg() : Mat4x4
    {
        return new Mat4x4(
          -xx, -xy, -xz, -xw,
          -yx, -yy, -yz, -yw,
          -zx, -zy, -zz, -zw,
          -wx, -wy, -wz, -ww
        );
    }

    @:op(A + B)
    public inline function add(B : Mat4x4) : Mat4x4
    {
        return new Mat4x4(
          xx + B.xx,    xy + B.xy,    xz + B.xz,    xw + B.xw,
          yx + B.yx,    yy + B.yy,    yz + B.yz,    yw + B.yw,
          zx + B.zx,    zy + B.zy,    zz + B.zz,    zw + B.zw,
          wx + B.wx,    wy + B.wy,    wz + B.wz,    ww + B.ww
        );
    }

    @:op(A - B)
    public inline function sub(B : Mat4x4) : Mat4x4
    {
        return new Mat4x4(
          xx - B.xx,    xy - B.xy,    xz - B.xz,    xw - B.xw,
          yx - B.yx,    yy - B.yy,    yz - B.yz,    yw - B.yw,
          zx - B.zx,    zy - B.zy,    zz - B.zz,    zw - B.zw,
          wx - B.wx,    wy - B.wy,    wz - B.wz,    ww - B.ww
        );
    }

    @:op(A * B)
    public inline function mul(B : Float) : Mat4x4
    {
        return new Mat4x4(
          xx * B,   xy * B,   xz * B,   xw * B,
          yx * B,   yy * B,   yz * B,   yw * B,
          zx * B,   zy * B,   zz * B,   zw * B,
          wx * B,   wy * B,   wz * B,   ww * B
        );
    }

    @:op(A * B)
    public inline function mulMat4x4(B : Mat4x4) : Mat4x4
    {
        return new Mat4x4(
          xx * B.xx + xy * B.yx + xz * B.zx + xw * B.wx,    xx * B.xy + xy * B.yy + xz * B.zy + xw * B.wy,    xx * B.xz + xy * B.yz + xz * B.zz + xw * B.wz,    xx * B.xw + xy * B.yw + xz * B.zw + xw * B.ww,
          yx * B.xx + yy * B.yx + yz * B.zx + yw * B.wx,    yx * B.xy + yy * B.yy + yz * B.zy + yw * B.wy,    yx * B.xz + yy * B.yz + yz * B.zz + yw * B.wz,    yx * B.xw + yy * B.yw + yz * B.zw + yw * B.ww,
          zx * B.xx + zy * B.yx + zz * B.zx + zw * B.wx,    zx * B.xy + zy * B.yy + zz * B.zy + zw * B.wy,    zx * B.xz + zy * B.yz + zz * B.zz + zw * B.wz,    zx * B.xw + zy * B.yw + zz * B.zw + zw * B.ww,
          wx * B.xx + wy * B.yx + wz * B.zx + ww * B.wx,    wx * B.xy + wy * B.yy + wz * B.zy + ww * B.wy,    wx * B.xz + wy * B.yz + wz * B.zz + ww * B.wz,    wx * B.xw + wy * B.yw + wz * B.zw + ww * B.ww
        );
    }
}
