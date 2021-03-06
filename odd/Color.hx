package odd;

import odd.math.Vec3;

/**
 * RGB color value abstracted over 24-bit integer.
 */
abstract Color(Int) from Int to Int
{
    public static var BLACK = Color.RGB(0x000000);
    public static var WHITE = Color.RGB(0xffffff);
    public static var RED = Color.RGB(0xff0000);
    public static var GREEN = Color.RGB(0x00ff00);
    public static var BLUE = Color.RGB(0x0000ff);
    public static var CYAN = Color.RGB(0x00ffff);
    public static var MAGENTA = Color.RGB(0xff00ff);
    public static var YELLOW = Color.RGB(0xffff00);

    /**
     * INT
     */
    
    /**
     * Red value as [0, 255] integer.
     */
    public var Ri(get, set) : Int;
    inline function get_Ri() : Int { return (this >> 16) & 0xff; }
    inline function set_Ri(r : Int) : Int { this = RGBi(r, Gi, Bi); return r; }
    
    /**
     * Green value as [0, 255] integer.
     */
    public var Gi(get, set) : Int;
    inline function get_Gi() : Int { return (this >> 8) & 0xff; }
    inline function set_Gi(g : Int) : Int { this = RGBi(Ri, g, Bi); return g; }
    
    /**
     * Blue value as [0, 255] integer.
     */
    public var Bi(get, set) : Int;
    inline function get_Bi() : Int { return this & 0xff; }
    inline function set_Bi(b : Int) : Int { this = RGBi(Ri, Gi, b); return b; }
    
    /**
     * FLOAT
     */
    
    /**
     * Red value as [0, 1] floating point.
     */
    public var Rf(get, set) : Float;
    inline function get_Rf() : Float { return Ri / 255; }
    inline function set_Rf(r : Float) : Float { this = RGBf(r, Gf, Bf); return r; }
    
    /**
     * Green value as [0, 1] floating point.
     */
    public var Gf(get, set) : Float;
    inline function get_Gf() : Float { return Gi / 255; }
    inline function set_Gf(g : Float) : Float { this = RGBf(Rf, g, Bf); return g; }
    
    /**
     * Blue value as [0, 1] floating point.
     */
    public var Bf(get, set) : Float;
    inline function get_Bf() : Float { return Bi / 255; }
    inline function set_Bf(b : Float) : Float { this = RGBf(Rf, Gf, b); return b; }
    
    inline function new(v : Int)
    {
        this = v;
    }
    
    /**
     * RGB from color value.
     * @param rgb   0xrrggbb color value
     * @return
     */
    public static inline function RGB(rgb : Int) : Color
    {
        return new Color(rgb);
    }
    
    /**
     * RGB from integer color components.
     * @param r [0, 255] red value
     * @param g [0, 255] green value
     * @param b [0, 255] blue value
     * @return
     */
    public static inline function RGBf(r : Float, g : Float, b : Float) : Color
    {
        return new Color((Std.int(r * 0xff) << 16) | (Std.int(g * 0xff) << 8) | Std.int(b * 0xff));
    }
    
    /**
     * RGB from float color components.
     * @param r [0, 1] red value
     * @param g [0, 1] green value
     * @param b [0, 1] blue value
     * @return
     */
    public static inline function RGBi(r : Int, g : Int, b : Int) : Color
    {
        return new Color(r << 16 | g << 8 | b);
    }
}