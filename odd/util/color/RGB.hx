package odd.util.color;

abstract RGB(Int) from Int to Int
{
    /**
     * Color constructor.
     * @param v Integer representation of color
     */
    inline function new(v : Int)
    {
        this = v;
    }
    
    //
    //  COMPONENTS AS INTEGERS
    //
    
    /**
     * Red value as [0, 255] integer.
     */
    public var ri(get, set) : Int;
    inline function get_ri() : Int { return (this >> 24) & 0xff; }
    inline function set_ri(r : Int) : Int { this = RGBAi(r, gi, bi, ai); return r; }
    
    /**
     * Green value as [0, 255] integer.
     */
    public var gi(get, set) : Int;
    inline function get_gi() : Int { return (this >> 16) & 0xff; }
    inline function set_gi(g : Int) : Int { this = RGBAi(ri, g, bi, ai); return g; }
    
    /**
     * Blue value as [0, 255] integer.
     */
    public var bi(get, set) : Int;
    inline function get_bi() : Int { return (this >> 8) & 0xff; }
    inline function set_bi(b : Int) : Int { this = RGBAi(ri, gi, b, ai); return b; }
    
    /**
     * Alpha value as [0, 255] integer.
     */
    public var ai(get, set) : Int;
    inline function get_ai() : Int { return this & 0xff; }
    inline function set_ai(a : Int) : Int { this = RGBAi(ri, gi, bi, a); return a; }
    
    //
    //  COMPONENTS AS FLOATS
    //
    
    /**
     * Red value as [0, 1] floating point.
     */
    public var rf(get, set) : Float;
    inline function get_rf() : Float { return ri / 255; }
    inline function set_rf(r : Float) : Float { this = RGBAf(r, gf, bf, af); return r; }
    
    /**
     * Green value as [0, 1] floating point.
     */
    public var gf(get, set) : Float;
    inline function get_gf() : Float { return gi / 255; }
    inline function set_gf(g : Float) : Float { this = RGBAf(rf, g, bf, af); return g; }
    
    /**
     * Blue value as [0, 1] floating point.
     */
    public var bf(get, set) : Float;
    inline function get_bf() : Float { return bi / 255; }
    inline function set_bf(b : Float) : Float { this = RGBAf(rf, gf, b, af); return b; }
    
    /**
     * Alpha value as [0, 1] floating point.
     */
    public var af(get, set) : Float;
    inline function get_af() : Float { return ai / 255; }
    inline function set_af(a : Float) : Float { this = RGBAf(rf, gf, bf, a); return a; }
    
    //
    //  CONSTRUCTORS
    //
    
    /**
     * RGB color from hex value.
     * @param hex 24b hex value
     * @return RGB color
     */
    public static inline function RGBh(hex : Int) : RGB
    {
        return new RGB((hex << 8) | 0xff);
    }
    
    /**
     * RGB color from integer components.
     * @param r Red value
     * @param g Green value
     * @param b Blue value
     * @return RGB color
     */
    public static inline function RGBi(r : Int, g : Int, b : Int) : RGB
    {
        return new RGB(r << 24 | g << 16 | b << 8 | 0xff);
    }
    
    /**
     * RGB color from float components.
     * @param r Red value
     * @param g Green value
     * @param b Blue value
     * @param c Color to sample from
     * @return RGB color
     */
    public static inline function RGBf(r : Float, g : Float, b : Float, ?c : RGB = RGB.RGBh(0xffffff)) : RGB
    {
        return new RGB((Std.int(r * c.ri) << 24) | (Std.int(g * c.gi) << 16) | (Std.int(b * c.bi) << 8) | 0xff);
    }
    
    /**
     * RGBA color from hex value.
     * @param hex 32b hex value
     * @return RGBA color
     */
    public static inline function RGBAh(hex : Int) : RGB
    {
        return new RGB(hex);
    }
    
    /**
     * RGBA color from integer components.
     * @param r Red value
     * @param g Green value
     * @param b Blue value
     * @param a Alpha value
     * @return RGBA color
     */
    public static inline function RGBAi(r : Int, g : Int, b : Int, a : Int) : RGB
    {
        return new RGB(r << 24 | g << 16 | b << 8 | a);
    }
    
    /**
     * RGBA color from float components.
     * @param r Red value
     * @param g Green value
     * @param b Blue value
     * @param a Alpha value
     * @param c Color to sample from
     * @return RGBA color
     */
    public static inline function RGBAf(r : Float, g : Float, b : Float, a : Float, ?c : RGB = RGB.RGBAh(0xffffffff)) : RGB
    {
        return new RGB((Std.int(r * c.ri) << 24) | (Std.int(g * c.gi) << 16) | (Std.int(b * c.bi) << 8) | (Std.int(a * c.ai)));
    }
}