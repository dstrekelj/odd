package odd.math;

/**
 * Four-by-four matrix of `Float` types.
 */
abstract Mat4x4(Array<Float>)
{
    inline public function new(
        xx : Float, xy : Float, xz : Float, xw : Float,
        yx : Float, yy : Float, yz : Float, yw : Float,
        zx : Float, zy : Float, zz : Float, zw : Float,
        wx : Float, wy : Float, wz : Float, ww : Float
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
    inline function get_xx() return this[0];
    inline function set_xx(xx : Float) return this[0] = xx;
    
    public var xy(get, set) : Float;
    inline function get_xy() return this[1];
    inline function set_xy(xy : Float) return this[1] = xy;
    
    public var xz(get, set) : Float;
    inline function get_xz() return this[2];
    inline function set_xz(xz : Float) return this[2] = xz;
    
    public var xw(get, set) : Float;
    inline function get_xw() return this[3];
    inline function set_xw(xw : Float) return this[3] = xw;
    
    public var yx(get, set) : Float;
    inline function get_yx() return this[4];
    inline function set_yx(yx : Float) return this[4] = yx;
    
    public var yy(get, set) : Float;
    inline function get_yy() return this[5];
    inline function set_yy(yy : Float) return this[5] = yy;
    
    public var yz(get, set) : Float;
    inline function get_yz() return this[6];
    inline function set_yz(yz : Float) return this[6] = yz;
    
    public var yw(get, set) : Float;
    inline function get_yw() return this[7];
    inline function set_yw(yw : Float) return this[7] = yw;
    
    public var zx(get, set) : Float;
    inline function get_zx() return this[8];
    inline function set_zx(zx : Float) return this[8] = zx;
    
    public var zy(get, set) : Float;
    inline function get_zy() return this[9];
    inline function set_zy(zy : Float) return this[9] = zy;
    
    public var zz(get, set) : Float;
    inline function get_zz() return this[10];
    inline function set_zz(zz : Float) return this[10] = zz;
    
    public var zw(get, set) : Float;
    inline function get_zw() return this[11];
    inline function set_zw(zw : Float) return this[11] = zw;
    
    public var wx(get, set) : Float;
    inline function get_wx() return this[12];
    inline function set_wx(wx : Float) return this[12] = wx;
    
    public var wy(get, set) : Float;
    inline function get_wy() return this[13];
    inline function set_wy(wy : Float) return this[13] = wy;
    
    public var wz(get, set) : Float;
    inline function get_wz() return this[14];
    inline function set_wz(wz : Float) return this[14] = wz;
    
    public var ww(get, set) : Float;
    inline function get_ww() return this[15];
    inline function set_ww(ww : Float) return this[15] = ww;
    
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
    
    /**
     * Note: `fieldOfView` >= 180° flips the image vertically.
     * 
     * @param fieldOfView   Vertical field of view, in degrees
     * @param aspectRatio
     * @param n
     * @param f
     * @return
     */
    public static inline function perspective(fieldOfView : Float, aspectRatio : Float, n : Float, f : Float) : Mat4x4
    {
        var t : Float = Math.tan(Angle.rad(fieldOfView) / 2) * n;
        var b : Float = -t;
        var r : Float = t * aspectRatio;
        var l : Float = -r;
        
        return new Mat4x4(
            (2 * n) / (r - l),  0,                  0,                      0,
            0,                  (2 * n) / (t - b),  0,                      0,
            (r + l) / (r - l),  (t + b) / (t - b), -(f + n) / (f - n),     -1,
            0,                  0,                 -(2 * f * n) / (f - n),  0
        );
    }
    
    public static inline function orthographic(b : Float, t : Float, l : Float, r : Float, n : Float, f : Float) : Mat4x4
    {
        return new Mat4x4(
            2 / (r - l),        0,                  0,                  0,
            0,                  2 / (t - b),        0,                  0,
            0,                  0,                 -2 / (f - n),        0,
           -(r + l) / (r - l), -(t + b) / (t - b), -(f + n) / (f - n),  1
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