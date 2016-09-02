package odd;

/**
 * The framebuffer allows per-pixel and per-channel operations.
 */
interface Framebuffer 
{
    public var width(default, null) : Int;
    public var height(default, null) : Int;
    public function clear(rgb : Int) : Void;
    public function getPixel(x : Int, y : Int) : Int;
    public function setPixel(x : Int, y : Int, rgb : Int) : Void;
}
