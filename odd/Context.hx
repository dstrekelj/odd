package odd;

/**
 * Stub.
 * 
 * The context should initialise a window and draw to it.
 * 
 * TODO: Have `Context` serve as an abstraction layer over
 * target-specific implementation.
 */
class Context
{
    public static var width(default, null) : Int;
    public static var height(default, null) : Int;
    
    private static var framebuffer : Framebuffer;
    
    public static function init(_width : Int, _height : Int) : Void
    {
        width = _width;
        height = _height;
        
        framebuffer = new Framebuffer(width, height);
    }
    
    public static function run(onUpdate : Void->Void, onDraw : Framebuffer->Void) : Void
    {
        onUpdate();
        onDraw(framebuffer);
    }
}
