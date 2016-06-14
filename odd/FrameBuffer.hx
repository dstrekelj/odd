package odd;

#if java
typedef FrameBuffer = odd._target.java.FrameBuffer;
#elseif js
typedef FrameBuffer = odd._target.js.FrameBuffer;
#else
import haxe.io.Bytes;
import haxe.io.BytesData;

/**
 * Pixel-based bytes buffer for depth and color buffers.
 */
class FrameBuffer
{
    /**
     * Buffer data.
     */
    var data : Bytes;
    
    /**
     * Buffer width.
     */
    var width : Int;
    
    /**
     * Buffer height.
     */
    var height : Int;
    
    /**
     * Bytes stored per pixel.
     */
    static inline var bytesPerPixel : Int = 4;
    
    /**
     * Allocates `width` * `height` * `bytesPerPixel` bytes for the
     * pixel buffer.
     * 
     * @param width Width of buffer
     * @param height Height of buffer
     */
    public function new(width : Int, height : Int)
    {
        this.width = width;
        this.height = height;
        
        data = Bytes.alloc(width * height * bytesPerPixel);
    }
    
    public inline function clear(c : Int) : Void
    {
        
    }
    
    /**
     * Gets color of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel color
     */
    public inline function getPixel(x : Int, y : Int) : Int
    {
        return getR(x, y) << 24 | getG(x, y) << 16 | getB(x, y) << 8 | getA(x, y);
    }

    /**
     * Gets red value of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel red value
     */
    public inline function getR(x : Int, y : Int) : Int
    {
        return getByte(x, y, 0);
    }

    /**
     * Gets green value of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel green value
     */
    public inline function getG(x : Int, y : Int) : Int
    {
        return getByte(x, y, 1);
    }

    /**
     * Gets blue value of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel blue value
     */
    public inline function getB(x : Int, y : Int) : Int
    {
        return getByte(x, y, 2);
    }

    /**
     * Gets alpha value of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel alpha value
     */
    public inline function getA(x : Int, y : Int) : Int
    {
        return getByte(x, y, 3);
    }

    /**
     * Sets color of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param color Pixel color
     */
    public inline function setPixel(x : Int, y : Int, v : Int) : Void
    {
        setR(x, y, (v >> 24) & 0xff);
        setG(x, y, (v >> 16) & 0xff);
        setB(x, y, (v >> 8) & 0xff);
        setA(x, y, v & 0xff);
    }

    /**
     * Sets red value of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param r Pixel red value
     */
    public inline function setR(x : Int, y : Int, r : Int) : Void
    {
        setByte(x, y, 0, r);
    }

    /**
     * Sets green value of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param g Pixel green value
     */
    public inline function setG(x : Int, y : Int, g : Int) : Void
    {
        setByte(x, y, 1, g);
    }

    /**
     * Sets blue value of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param b Pixel blue value
     */
    public inline function setB(x : Int, y : Int, b : Int) : Void
    {
        setByte(x, y, 2, b);
    }

    /**
     * Sets alpha value of (x, y) pixel (relative to top-left corner).
     *
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param a Pixel alpha value
     */
    public inline function setA(x : Int, y : Int, a : Int) : Void
    {
        setByte(x, y, 3, a);
    }
    
    /**
     * Retrieves buffer data as `haxe.io.BytesData`.
     * 
     * @return Buffer data
     */
    public inline function getData() : BytesData
    {
        return data.getData();
    }
    
    /**
     * Gets `b` byte of (x, y) pixel (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param b Byte (component)
     * @return Value
     */
    private inline function getByte(x : Int, y : Int, b : Int) : Int
    {
        return data.get(getIndex(x, y) + b);
    }
    
    /**
     * Sets `b` byte of (x, y) pixel (relative to top-left corner).
     * Only sets if `0 <= x < width` and `0 <= y < height`.
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param b Byte (component)
     * @param v Value
     */
    private inline function setByte(x : Int, y : Int, b : Int, v : Int) : Void
    {
        // TODO: Implement proper clip space in pipeline
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            data.set(getIndex(x, y) + b, v);
        }
    }
    
    /**
     * Gets index of (x, y) pixel (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Index of pixel
     */
    private inline function getIndex(x : Int, y : Int) : Int
    {
        return (x + y * width) * bytesPerPixel;
    }
}
#end