package odd.data;

import haxe.io.Bytes;

/**
 * Per-pixel bytes buffer.
 */
class PixelBuffer
{
    // Buffer bytes
    public var bytes(get, null) : Bytes;
    
    // Buffer width
    public var width(default, null) : Int;
    
    // Buffer height
    public var height(default, null) : Int;
    
    // Bytes stored per pixel
    public var bytesPerPixel(default, null) : Int;
    
    /**
     * Allocates `width` * `height` * `bytesPerPixel` bytes for the
     * pixel buffer.
     * 
     * @param width Width of buffer
     * @param height Height of buffer
     * @param bytesPerPixel Bytes stored per pixel
     */
    public function new(width : Int, height : Int, bytesPerPixel : Int)
    {
        this.width = width;
        this.height = height;
        this.bytesPerPixel = bytesPerPixel;
        
        bytes = Bytes.alloc(width * height * bytesPerPixel);
    }
    
    /**
     * From `start` position, copies `length` amount of `source` bytes
     * from `sourceStart` onward. This operation has almost no cost
     * and is useful for clearing the buffer.
     * 
     * @param start Point at which to begin storing source bytes
     * @param source Source bytes
     * @param sourceStart Point at which to begin copying source bytes
     * @param length Amount of source bytes to copy (in bytes)
     */
    public inline function blit(start : Int, source : Bytes, sourceStart : Int, length : Int) : Void
    {
        bytes.blit(start, source, sourceStart, length);
    }
    
    /**
     * Retrieves buffer bytes as `haxe.io.Bytesbytes`.
     * 
     * @return Buffer bytes
     */
    private inline function get_bytes() : Bytes
    {
        return bytes;
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
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            return bytes.get(getIndex(x, y) + b);
        }
        return -1;
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
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            bytes.set(getIndex(x, y) + b, v);
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
