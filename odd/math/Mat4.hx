package odd.math;

import odd.math.Vec3.Vector3;
import odd.math.Vec4.Vector4;

class Mat4
{
    public var xx : Float;  public var xy : Float;  public var xz : Float;  public var xw : Float;
    public var yx : Float;  public var yy : Float;  public var yz : Float;  public var yw : Float;
    public var zx : Float;  public var zy : Float;  public var zz : Float;  public var zw : Float;
    public var wx : Float;  public var wy : Float;  public var wz : Float;  public var ww : Float;

    public function new(
        xx : Float, xy : Float, xz : Float, xw : Float,
        yx : Float, yy : Float, yz : Float, yw : Float,
        zx : Float, zy : Float, zz : Float, zw : Float,
        wx : Float, wy : Float, wz : Float, ww : Float
    )
    {
        this.xx = xx; this.xy = xy; this.xz = xz; this.xw = xw;
        this.yx = yx; this.yy = yy; this.yz = yz; this.yw = yw;
        this.zx = zx; this.zy = zy; this.zz = zz; this.zw = zw;
        this.wx = wx; this.wy = wy; this.wz = wz; this.ww = ww;
    }

    public function toString() : String
    {
        return '{ { $xx, $xy, $xz, $xw }, { $yx, $yy, $yz, $yw }, { $zx, $zy, $zz, $zw }, { $wx, $wy, $wz, $ww } }';
    }
}

@:forward(
    xx, xy, xz, xw,
    yx, yy, yz, yw,
    zx, zy, zz, zw,
    wx, wy, wz, ww
)
abstract Matrix4(Mat4) from Mat4 to Mat4
{
    inline public function new(
        xx : Float, xy : Float, xz : Float, xw : Float,
        yx : Float, yy : Float, yz : Float, yw : Float,
        zx : Float, zy : Float, zz : Float, zw : Float,
        wx : Float, wy : Float, wz : Float, ww : Float
    )
    {
        this = new Mat4(
            xx, xy, xz, xw,
            yx, yy, yz, yw,
            zx, zy, zz, zw,
            wx, wy, wz, ww
        );
    }

    inline public static function identity() : Matrix4
    {
        return new Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1
        );
    }

    inline public static function empty() : Matrix4
    {
        return new Matrix4(
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        );
    }

    inline public static function translate(x : Float, y : Float, z : Float) : Matrix4
    {
        return new Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            x, y, z, 1
        );
    }
    
    inline public static function scale(x : Float, y : Float, z : Float) : Matrix4
    {
        return new Matrix4(
            x, 0, 0, 0,
            0, y, 0, 0,
            0, 0, z, 0,
            0, 0, 0, 1
        );
    }

    public static function rotateX(a : Float) : Matrix4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Matrix4(
            1,  0,  0,  0,
            0,  c,  s,  0,
            0, -s,  c,  0,
            0,  0,  0,  1
        );
    }

    public static function rotateY(a : Float) : Matrix4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Matrix4(
            c,  0, -s,  0,
            0,  1,  0,  0,
            s,  0,  c,  0,
            0,  0,  0,  1
        );
    }

    public static function rotateZ(a : Float) : Matrix4
    {
        var c : Float = Math.cos(a);
        var s : Float = Math.sin(a);
        return new Matrix4(
            c,  s,  0,  0,
           -s,  c,  0,  0,
            0,  0,  1,  0,
            0,  0,  0,  1
        );
    }

    public static function rotate(roll : Float, pitch : Float, yaw : Float) : Matrix4
    {
        var cx : Float = Math.cos(roll);
        var sx : Float = Math.sin(roll);
        
        var cy : Float = Math.cos(pitch);
        var sy : Float = Math.sin(pitch);
        
        var cz : Float = Math.cos(yaw);
        var sz : Float = Math.sin(yaw);
        
        return new Matrix4(
            cz * cy,                    sz * sy,                   -sy,         0,
            cz * sy * sx - sz * cx,     sz * sy * sx + cz * cx,     cy * sx,    0,
            cz * sy * cx + sz * sx,     sz * sy * cx - cz * sx,     cy * cx,    0,
            0,                          0,                          0,          1
        );
    }
    
    inline public static function screenSpace(halfWidth : Float, halfHeight : Float) : Matrix4
    {
        return new Matrix4(
            halfWidth,  0,          0,  0,
            0,         -halfHeight, 0,  0,
            0,          0,          1,  0,
            halfWidth,  halfHeight, 0,  1
        );
    }
    
    public static function perspective(fieldOfView : Float, aspectRatio : Float, near : Float, far : Float) : Matrix4
    {
        var t : Float = Math.tan(fieldOfView / 2);
        var r : Float = near - far;
        
        return new Matrix4(
            1 / (t * aspectRatio),  0,      0,                      0,
            0,                      1 / t,  0,                      0,
            0,                      0,      ( -near - far) / r,     2 * near * far / r,
            0,                      0,      1,                      0
        );
    }
    
    public static function projection(left : Float, right : Float, top : Float, bottom : Float, near : Float, far : Float) : Matrix4
    {
        return new Matrix4(
            (2 * near) / (right - left),    0,                              (right + left) / (right - left),    0,
            0,                              (2 * near) / (top - bottom),    (top + bottom) / (top - bottom),    0,
            0,                              0,                             -(far + near) / (far - near),       -(2 * far * near) / (far - near),
            0,                              0,                              1,                                  0
        );
    }

    @:op(-A)
    inline function negate() : Matrix4
    {
        return new Matrix4(
          -this.xx, -this.xy, -this.xz, -this.xw,
          -this.yx, -this.yy, -this.yz, -this.yw,
          -this.zx, -this.zy, -this.zz, -this.zw,
          -this.wx, -this.wy, -this.wz, -this.ww
        );
    }

    @:op(A + B)
    inline function add(B : Matrix4) : Matrix4
    {
        return new Matrix4(
          this.xx + B.xx, this.xy + B.xy, this.xz + B.xz, this.xw + B.xw,
          this.yx + B.yx, this.yy + B.yy, this.yz + B.yz, this.yw + B.yw,
          this.zx + B.zx, this.zy + B.zy, this.zz + B.zz, this.zw + B.zw,
          this.wx + B.wx, this.wy + B.wy, this.wz + B.wz, this.ww + B.ww
        );
    }

    @:op(A - B)
    inline function subtract(B : Matrix4) : Matrix4
    {
        return new Matrix4(
          this.xx - B.xx, this.xy - B.xy, this.xz - B.xz, this.xw - B.xw,
          this.yx - B.yx, this.yy - B.yy, this.yz - B.yz, this.yw - B.yw,
          this.zx - B.zx, this.zy - B.zy, this.zz - B.zz, this.zw - B.zw,
          this.wx - B.wx, this.wy - B.wy, this.wz - B.wz, this.ww - B.ww
        );
    }

    @:op(A * B)
    inline function multiplyScalar(B : Float) : Matrix4
    {
        return new Matrix4(
          this.xx * B, this.xy * B, this.xz * B, this.xw * B,
          this.yx * B, this.yy * B, this.yz * B, this.yw * B,
          this.zx * B, this.zy * B, this.zz * B, this.zw * B,
          this.wx * B, this.wy * B, this.wz * B, this.ww * B
        );
    }

    @:op(A * B)
    function multiplyVector3(B : Vector3) : Vector3
    {
        var v = new Vector3();
        v.x = this.xx * B.x + this.yx * B.y + this.zx * B.z + this.wx;
        v.y = this.xy * B.x + this.yy * B.y + this.zy * B.z + this.wy;
        v.z = this.xz * B.x + this.yz * B.y + this.zz * B.z + this.wz;
        
        var w : Float = this.xw * B.x + this.xy * B.y + this.xz * B.z + this.ww;
        
        if (w != 1 && w != 0)
        {
            v.x /= w;
            v.y /= w;
            v.z /= w;
        }
        
        return v;
    }
    
    @:op(A * B)
    inline function multiplyVector4(B : Vector4) : Vector4
    {
        return new Vector4(
          this.xx * B.x + this.yx * B.y + this.zx * B.z + this.wx * B.w,
          this.xy * B.x + this.yy * B.y + this.zy * B.z + this.wy * B.w,
          this.xz * B.x + this.yz * B.y + this.zz * B.z + this.wz * B.w,
          this.xw * B.x + this.yw * B.y + this.zw * B.z + this.ww * B.w
        );
    }

    @:op(A * B)
    inline function multiplyMatrix(B : Matrix4) : Matrix4
    {
        return new Matrix4(
          this.xx * B.xx + this.xy * B.yx + this.xz * B.zx + this.xw * B.wx, this.xx * B.xy + this.xy * B.yy + this.xz * B.zy + this.xw * B.wy, this.xx * B.xz + this.xy * B.yz + this.xz * B.zz + this.xw * B.wz, this.xx * B.xw + this.xy * B.yw + this.xz * B.zw + this.xw * B.ww,
          this.yx * B.xx + this.yy * B.yx + this.yz * B.zx + this.yw * B.wx, this.yx * B.xy + this.yy * B.yy + this.yz * B.zy + this.yw * B.wy, this.yx * B.xz + this.yy * B.yz + this.yz * B.zz + this.yw * B.wz, this.yx * B.xw + this.yy * B.yw + this.yz * B.zw + this.yw * B.ww,
          this.zx * B.xx + this.zy * B.yx + this.zz * B.zx + this.zw * B.wx, this.zx * B.xy + this.zy * B.yy + this.zz * B.zy + this.zw * B.wy, this.zx * B.xz + this.zy * B.yz + this.zz * B.zz + this.zw * B.wz, this.zx * B.xw + this.zy * B.yw + this.zz * B.zw + this.zw * B.ww,
          this.wx * B.xx + this.wy * B.yx + this.wz * B.zx + this.ww * B.wx, this.wx * B.xy + this.wy * B.yy + this.wz * B.zy + this.ww * B.wy, this.wx * B.xz + this.wy * B.yz + this.wz * B.zz + this.ww * B.wz, this.wx * B.xw + this.wy * B.yw + this.wz * B.zw + this.ww * B.ww
        );
    }
}