package odd._target.js;

import odd._target.js.FrameBufferData;

class FrameBuffer
{
    var data : FrameBufferData;
    var width : Int;
    var height : Int;
    
    static inline var channels : Int = 4;
    
    public function new(width : Int, height : Int)
    {
        trace('-- js buffer --');
        this.width = width;
        this.height = height;
        this.data = new FrameBufferData(width * height * channels);
    }
    
    public inline function clear(rgba : Int) : Void
    {
        for (x in 0...width)
        {
            for (y in 0...height)
            {
                setPixel(x, y, rgba);
            }
        }
    }
    
    public inline function getData() : FrameBufferData
    {
        return data;
    }
    
    /**
     * Gets (x, y) pixel colour.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @return Pixel colour.
     */
    public inline function getPixel(x : Int, y : Int) : Int
    {
        return getR(x, y) << 24 | getG(x, y) << 16 | getB(x, y) << 8 | getA(x, y);
    }
    
    /**
     * Gets (x, y) pixel red channel.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @return Pixel red channel.
     */
    public inline function getR(x : Int, y : Int) : Int
    {
        return read(x, y, 0);
    }
    
    /**
     * Gets (x, y) pixel green channel.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @return Pixel green channel.
     */
    public inline function getG(x : Int, y : Int) : Int
    {
        return read(x, y, 1);
    }
    
    /**
     * Gets (x, y) pixel blue channel.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @return Pixel blue channel.
     */
    public inline function getB(x : Int, y : Int) : Int
    {
        return read(x, y, 2);
    }
    
    /**
     * Gets (x, y) pixel alpha channel.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @return Pixel alpha channel.
     */
    public inline function getA(x : Int, y : Int) : Int
    {
        return read(x, y, 3);
    }
    
    /**
     * Sets (x, y) pixel colour.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @param v Colour value.
     */
    public inline function setPixel(x : Int, y : Int, rgba : Int) : Void
    {
        setR(x, y, (rgba >> 24) & 0xff);
        setG(x, y, (rgba >> 16) & 0xff);
        setB(x, y, (rgba >> 8) & 0xff);
        setA(x, y, rgba & 0xff);
    }
    
    /**
     * Sets (x, y) pixel red channel.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @param r Red channel value.
     */
    public inline function setR(x : Int, y : Int, r : Int) : Void
    {
        write(x, y, 0, r);
    }
    
    /**
     * Sets (x, y) pixel green channel.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @param g Green channel value.
     */
    public inline function setG(x : Int, y : Int, g : Int) : Void
    {
        write(x, y, 1, g);
    }
    
    /**
     * Sets (x, y) pixel blue channel.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @param b Blue channel value.
     */
    public inline function setB(x : Int, y : Int, b : Int) : Void
    {
        write(x, y, 2, b);
    }
    
    /**
     * Sets (x, y) pixel alpha channel.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @param a Alpha channel value.
     */
    public inline function setA(x : Int, y : Int, a : Int) : Void
    {
        write(x, y, 3, a);
    }
    
    /**
     * Reads value of (x, y) pixel channel `c` from buffer.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @param c Channel.
     * @return  Value.
     */
    private inline function read(x : Int, y : Int, c : Int) : Int
    {
        return data[getIndex(x, y) + c];
    }
    
    /**
     * Writes value of (x, y) pixel channel `c` to buffer.
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @param c Channel.
     * @param v Value.
     */
    private inline function write(x : Int, y : Int, c : Int, v : Int) : Void
    {
        data[getIndex(x, y) + c] = v;
    }
    
    /**
     * Gets index of (x, y) pixel in buffer (relative to top-left corner).
     * 
     * @param x Horizontal pixel position.
     * @param y Vertical pixel position.
     * @return  Index of pixel in buffer.
     */
    private inline function getIndex(x : Int, y : Int) : Int
    {
        return (x + y * width) * channels;
    }
}