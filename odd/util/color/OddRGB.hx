package odd.util.color;

abstract OddRGB(Int) from Int to Int
{
    /**
     * INT
     */
    
    /**
     * Red value as [0, 255] integer.
     */
    public var Ri(get, set) : Int;
    inline function get_Ri() : Int { return (this >> 24) & 0xff; }
    inline function set_Ri(r : Int) : Int { this = RGBAc(r, Gi, Bi, Ai); return r; }
    
    /**
     * Green value as [0, 255] integer.
     */
    public var Gi(get, set) : Int;
    inline function get_Gi() : Int { return (this >> 16) & 0xff; }
    inline function set_Gi(g : Int) : Int { this = RGBAc(Ri, g, Bi, Ai); return g; }
    
    /**
     * Blue value as [0, 255] integer.
     */
    public var Bi(get, set) : Int;
    inline function get_Bi() : Int { return (this >> 8) & 0xff; }
    inline function set_Bi(b : Int) : Int { this = RGBAc(Ri, Gi, b, Ai); return b; }
    
    /**
     * Alpha value as [0, 255] integer.
     */
    public var Ai(get, set) : Int;
    inline function get_Ai() : Int { return this & 0xff; }
    inline function set_Ai(a : Int) : Int { this = RGBAc(Ri, Gi, Bi, a); return a; }
    
    /**
     * FLOAT
     */
    
    /**
     * Red value as [0, 1] floating point.
     */
    public var Rf(get, set) : Float;
    inline function get_Rf() : Float { return Ri / 255; }
    inline function set_Rf(r : Float) : Float { this = RGBAf(r, Gf, Bf, Af); return r; }
    
    /**
     * Green value as [0, 1] floating point.
     */
    public var Gf(get, set) : Float;
    inline function get_Gf() : Float { return Gi / 255; }
    inline function set_Gf(g : Float) : Float { this = RGBAf(Rf, g, Bf, Af); return g; }
    
    /**
     * Blue value as [0, 1] floating point.
     */
    public var Bf(get, set) : Float;
    inline function get_Bf() : Float { return Bi / 255; }
    inline function set_Bf(b : Float) : Float { this = RGBAf(Rf, Gf, b, Af); return b; }
    
    /**
     * Alpha value as [0, 1] floating point.
     */
    public var Af(get, set) : Float;
    inline function get_Af() : Float { return Ai / 255; }
    inline function set_Af(a : Float) : Float { this = RGBAf(Rf, Gf, Bf, a); return a; }
    
    inline function new(v : Int)
    {
        this = v;
    }
    
    public static inline function RGB(rgb : Int) : OddRGB
    {
        return new OddRGB((rgb << 8) | 0xff);
    }
    
    public static inline function RGBA(rgba : Int) : OddRGB
    {
        return new OddRGB(rgba);
    }
    
    public static inline function RGBf(r : Float, g : Float, b : Float, ?c : OddRGB = OddRGB.RGB(0xffffff)) : OddRGB
    {
        return new OddRGB((Std.int(r * c.Ri) << 24) | (Std.int(g * c.Gi) << 16) | (Std.int(b * c.Bi) << 8) | 0xff);
    }
    
    public static inline function RGBAf(r : Float, g : Float, b : Float, a : Float, ?c : OddRGB = OddRGB.RGBA(0xffffffff)) : OddRGB
    {
        return new OddRGB((Std.int(r * c.Ri) << 24) | (Std.int(g * c.Gi) << 16) | (Std.int(b * c.Bi) << 8) | (Std.int(a * c.Ai)));
    }
    
    public static inline function RGBc(r : Int, g : Int, b : Int) : OddRGB
    {
        return new OddRGB(r << 24 | g << 16 | b << 8 | 0xff);
    }
    
    public static inline function RGBAc(r : Int, g : Int, b : Int, a : Int) : OddRGB
    {
        return new OddRGB(r << 24 | g << 16 | b << 8 | a);
    }
}