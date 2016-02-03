package odd;
import odd.display.OddImage;
import odd.util.OddColor;

class OddContext
{
    public var width(default, null) : Int;
    public var height(default, null) : Int;
    public var image(default, null) : OddImage;
    
    public function new(width : Int, height : Int, clearColor : OddColor) 
    {
        this.width = width;
        this.height = height;
        this.image = new OddImage(width, height, clearColor);
    }
}