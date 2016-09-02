package odd;

import odd.impl.ContextImpl;

/**
 * Stub.
 * 
 * The context should initialise a window and draw to it.
 */
class Context
{
    public static var width(get, null) : Int;
    inline static function get_width() return context.framebuffer.width;
    
    public static var height(get, null) : Int;
    inline static function get_height() return context.framebuffer.height;
    
    private static var context : ContextImpl;
    
    public static function init(width : Int, height : Int) : Void
    {
        trace("-- odd --");
        
        if (context == null)
        {
            context = new ContextImpl(width, height);
        }
    }
    
    public static function run(onUpdate : Void->Void, onDraw : Framebuffer->Void) : Void
    {
        if (context != null)
        {
            context.run(onUpdate, onDraw);
        }
    }
}
