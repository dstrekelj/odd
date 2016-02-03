package odd.util;

abstract OddColor(Int) from Int to Int
{
    public var r(get, never) : Int;
    inline function get_r() : Int { return (this >> 24) & 0xff; }
    
    public var g(get, never) : Int;
    inline function get_g() : Int { return (this >> 16) & 0xff; }
    
    public var b(get, never) : Int;
    inline function get_b() : Int { return (this >> 8) & 0xff; }
    
    public var a(get, never) : Int;
    inline function get_a() : Int { return this & 0xff; }
    
    inline function new(v : Int)
    {
        this = v;
    }
    
    public static inline function RGB(rgb : Int) : OddColor
    {
        return new OddColor((rgb << 8) | 0xff);
    }
    
    public static inline function RGBA(rgba : Int) : OddColor
    {
        return new OddColor(rgba);
    }
}