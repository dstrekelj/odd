package odd;

/**
 * Framebuffer stub.
 * 
 * The framebuffer should allow per-pixel and per-channel operations.
 */
class Framebuffer 
{
    public var width(default, null) : Int;
    public var height(default, null) : Int;
    public var data(default, null) : Array<Int>;
    
    public function new(width : Int, height : Int)
    {
        this.width = width;
        this.height = height;
    }
    
    public function clear(rgb : Int) : Void {}
    
    public function getPixel(x : Int, y : Int) : Int { return -1; }
    public function getR(x : Int, y : Int) : Int { return -1; }
    public function getG(x : Int, y : Int) : Int { return -1; }
    public function getB(x : Int, y : Int) : Int { return -1; }
    
    public function setPixel(x : Int, y : Int, rgb : Int) : Void {}
    public function setR(x : Int, y : Int, r : Int) : Void {}
    public function setG(x : Int, y : Int, g : Int) : Void {}
    public function setB(x : Int, y : Int, b : Int) : Void {}
}
