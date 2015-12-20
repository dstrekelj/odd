package odd;
import haxe.io.Bytes;
import haxe.io.BytesData;

/**
 * All image data is handled by the `ImageBuffer`. It describes
 * methods to get and set pixels of the final rendered image.
 */
class ImageBuffer
{
    /**
     * Width of image
     */
    public var width(default, null) : Int;
    /**
     * Height of image
     */
    public var height(default, null) : Int;
    
    /**
     * Image buffer data
     */
    var data : Bytes;
    /**
     * Buffer data of image used for clearing
     */
    var clearData : Bytes;
    /**
     * Clear color
     */
    var clearColor : Int;
    
    /**
     * Creates new image buffer.
     * 
     * @param width Image width
     * @param height Image height
     */
    public function new(width : Int, height : Int)
    {
        this.width = width;
        this.height = height;
        
        // Image pixel count is multiplied by four because of ABGR color components
        data = Bytes.alloc(width * height * 4);
        // Black is the default clear color (note ABGR notation)
        clearColor = 0xff000000;
        // Creation of clear buffer, which is blitted onto image buffer on clear
        clearData = Bytes.alloc(width * height * 4);
        for (i in 0...width) {
            for (j in 0...height) {
                clearData.setInt32(getIndex(i, j), clearColor);
            }
        }
        
        clear();
    }
    
    /**
     * Clears the image buffer with desired clear color.
     * 
     * @param color Clear color
     */
    public inline function clear(?color : Int) : Void
    {
        if (color != null && color != clearColor) {
            for (i in 0...width) {
                for (j in 0...height) {
                    clearData.setInt32(getIndex(i, j), clearColor);
                }
            }
        }
        
        data.blit(0, clearData, 0, clearData.length);
    }
    
    /**
     * Gets buffer data.
     * 
     * @return Buffer data as `haxe.io.BytesData`
     */
    public inline function getData() : BytesData
    {
        return data.getData();
    }
    
    /**
     * Gets pixel color at x, y position in image (relative
     * to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel color
     */
    public function getPixel(x : Int, y : Int) : Int
    {
        return getR(x, y) << 24 | getG(x, y) << 16 | getB(x, y) << 8 | getA(x, y);
    }
    
    /**
     * Gets red value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel red value
     */
    public inline function getR(x : Int, y : Int) : Int
    {
        return getComponent(x, y, 0);
    }
    
    /**
     * Gets green value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel green value
     */
    public inline function getG(x : Int, y : Int) : Int
    {
        return getComponent(x, y, 1);
    }
    
    /**
     * Gets blue value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel blue value
     */
    public inline function getB(x : Int, y : Int) : Int
    {
        return getComponent(x, y, 2);
    }
    
    /**
     * Gets alpha value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Pixel alpha value
     */
    public inline function getA(x : Int, y : Int) : Int
    {
        return getComponent(x, y, 3);
    }
    
    /**
     * Sets color of pixel at x, y position in image (relative
     * to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param color Pixel color
     */
    public function setPixel(x : Int, y : Int, color : Int) : Void
    {
        setR(x, y, (color & 0xff000000) >>> 24);
        setG(x, y, (color & 0x00ff0000) >>> 16);
        setB(x, y, (color & 0x0000ff00) >>> 8);
        setA(x, y, (color & 0x000000ff));
    }
    
    /**
     * Sets red value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param r Pixel red value
     */
    public inline function setR(x : Int, y : Int, r : Int) : Void
    {
        setComponent(x, y, 0, r);
    }
    
    /**
     * Sets green value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param g Pixel green value
     */
    public inline function setG(x : Int, y : Int, g : Int) : Void
    {
        setComponent(x, y, 1, g);
    }
    
    /**
     * Sets blue value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param b Pixel blue value
     */
    public inline function setB(x : Int, y : Int, b : Int) : Void
    {
        setComponent(x, y, 2, b);
    }
    
    /**
     * Sets alpha value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param a Pixel alpha value
     */
    public inline function setA(x : Int, y : Int, a : Int) : Void
    {
        setComponent(x, y, 3, a);
    }
    
    /**
     * Gets component value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param c Pixel component number (0 - Alpha, 1 - Blue, 2 - Green, 3 - Red)
     * @return Pixel component value
     */
    private inline function getComponent(x : Int, y : Int, c : Int) : Int
    {
        return data.get(getIndex(x, y) + c);
    }
    
    /**
     * Sets component value of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @param c Pixel component number (0 - Alpha, 1 - Blue, 2 - Green, 3 - Red)
     * @param v Pixel component value
     */
    private inline function setComponent(x : Int, y : Int, c : Int, v : Int) : Void
    {
        data.set(getIndex(x, y) + c, v);
    }
    
    /**
     * Gets buffer index of pixel at x, y position in image
     * (relative to top-left corner).
     * 
     * @param x Horizontal position of pixel
     * @param y Vertical position of pixel
     * @return Index of pixel in image buffer
     */
    private inline function getIndex(x : Int, y : Int) : Int
    {
        return (x + y * width) * 4;
    }
}