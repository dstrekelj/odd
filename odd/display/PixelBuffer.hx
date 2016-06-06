package odd.display;

import haxe.io.Bytes;
import haxe.io.BytesData;

/**
 * Pixel-based bytes buffer for depth and color buffers.
 */
class PixelBuffer
{
    // Buffer data
    var data : Bytes;
    
    // Buffer width
    var width : Int;
    
    // Buffer height
    var height : Int;
    
    // Bytes stored per pixel
    var bytesPerPixel : Int;
    
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
        
        data = Bytes.alloc(width * height * bytesPerPixel);
    }
    
    /**
     * From `start` position, copies `length` amount of `source` data
     * from `sourceStart` onward. This operation has almost no cost
     * and is useful for clearing the buffer.
     * 
     * @param start Point at which to begin storing source data
     * @param source Source data
     * @param sourceStart Point at which to begin copying source data
     * @param length Amount of source data to copy (in bytes)
     */
    public inline function blit(start : Int, source : Bytes, sourceStart : Int, length : Int) : Void
    {
        data.blit(start, source, sourceStart, length);
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