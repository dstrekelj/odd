package odd.data;

import haxe.io.Bytes;

/**
 * Stores depth values per-pixel.
 */
class DepthBuffer extends PixelBuffer
{
    static var clearData : Bytes;
    
    /**
     * Creates new depth buffer of `width * height * 8` size for
     * storing depths as double precision floating point values.
     * Initialized to Math.POSITIVE_INFINITY.
     * 
     * @param width Width of buffer
     * @param height Height of buffer
     */
    public function new(width : Int, height : Int) : Void
    {
        super(width, height, 8);
        
        if (clearData == null)
        {
            clearData = Bytes.alloc(width * height * 8);
            reset(clearData);
        }
        
        clear();
    }
    
    /**
     * Clears buffer to Math.NEGATIVE_INFINITY (becausecamera looks
     * down negative z-axis).
     */
    public inline function clear() : Void
    {
        blit(0, clearData, 0, width * height * 8);
    }
    
    /**
     * Gets depth value at (x, y) pixel (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Value
     */
    public inline function get(x : Int, y : Int) : Float
    {
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            return bytes.getDouble(getIndex(x, y));
        }
        return Math.POSITIVE_INFINITY;
    }
    
    /**
     * Sets depth value at (x, y) pixel (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param v Value
     */
    public inline function set(x : Int, y : Int, v : Float) : Void
    {
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            bytes.setDouble(getIndex(x, y), v);
        }
    }
    
    private inline function reset(bytesData : Bytes) : Void
    {
        for (y in 0...height) for (x in 0...width) bytesData.setDouble(getIndex(x, y), Math.POSITIVE_INFINITY);
    }
}
