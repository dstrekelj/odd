package odd.display;

import haxe.io.Bytes;
import odd.util.color.RGB;

class ColorBuffer extends PixelBuffer
{
    /**
     * Creates new color buffer of `width * height` size and clears it
     * to desired color.
     * 
     * @param width Width of buffer
     * @param height Height of buffer
     * @param color Initial color of pixels in buffer
     */
    public function new(width : Int, height : Int, ?color : RGB = 0x000000ff)
    {
        super(width, height, 4);
        
        clear(color);
    }
    
    /**
     * Clears buffer to desired color.
     * 
     * @param c Clear color
     */
    private inline function clear(c : RGB) : Void
    {
        for (y in 0...height)
        {
            for (x in 0...width)
            {
                setPixel(x, y, c);
            }
        }
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
    public inline function setPixel(x : Int, y : Int, c : RGB) : Void
    {
        setR(x, y, c.ri);
        setG(x, y, c.gi);
        setB(x, y, c.bi);
        setA(x, y, c.ai);
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
}