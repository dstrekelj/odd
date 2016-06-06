package odd.display;

class DepthBuffer extends PixelBuffer
{
    /**
     * Creates new depth buffer of `width * height * 8` size for
     * storing depths as double precision floating point values.
     * Initialized to Math.POSITIVE_INFINITY.
     * 
     * @param width Width of buffer
     * @param height Height of buffer
     */
    public function new(width : Int, height : Int)
    {
        super(width, height, 8);
        
        clear();
    }
    
    /**
     * Clears buffer to Math.POSITIVE_INFINITY.
     */
    private inline function clear() : Void
    {
        for (y in 0...height)
        {
            for (x in 0...width)
            {
                data.setDouble(getIndex(x, y), Math.POSITIVE_INFINITY);
            }
        }
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
        // TODO: Implement proper clip space in pipeline
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            return data.getDouble(getIndex(x, y));
        }
        return 0;
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
        // TODO: Implement proper clip space in pipeline
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            data.setDouble(getIndex(x, y), v);
        }
    }
}