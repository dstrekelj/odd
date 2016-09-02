package odd;

import odd.data.PixelBuffer;
import odd.Color;

class Texture extends PixelBuffer
{
    public function new(width : Int, height : Int) : Void
    {
        super(width, height, 3);
    }
    
    public function sample(u : Float, v : Float) : Color
    {
        return Color.RGBi(
            getByte(Std.int(u * width), Std.int(v * height), 0),
            getByte(Std.int(u * width), Std.int(v * height), 1),
            getByte(Std.int(u * width), Std.int(v * height), 2)
        );
    }
    
    public function setPixel(x : Int, y : Int, rgb : Color) : Void
    {
        setByte(x, y, 0, rgb.Ri);
        setByte(x, y, 1, rgb.Gi);
        setByte(x, y, 2, rgb.Bi);
    }
    
    public function getPixel(x : Int, y : Int) : Color
    {
        return Color.RGBi(
            getByte(x, y, 0),
            getByte(x, y, 1),
            getByte(x, y, 2)
        );
    }
}