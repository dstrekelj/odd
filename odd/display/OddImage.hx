package odd.display;

import odd.math.OddVec2;
import odd.util.color.OddRGB;

class OddImage
{
    /**
     * Color buffer.
     */
    public var colorBuffer(default, null) : OddColorBuffer;
    
    /**
     * Depth buffer.
     */
    public var depthBuffer(default, null) : OddDepthBuffer;
    
    /**
     * Creates new color and depth buffers.
     * 
     * @param width Width of both buffers
     * @param height Height of both buffers
     * @param color Clear color of color buffer
     */
    public function new(width : Int, height : Int, ?color : OddRGB = 0x000000ff)
    {
        colorBuffer = new OddColorBuffer(width, height, color);
        depthBuffer = new OddDepthBuffer(width, height);
    }
    
    /**
     * Colors pixel at (x, y) if `z` is smaller than current depth
     * value of that pixel. Affects depth buffer.
     * 
     * @param x Pixel horizontal position
     * @param y Pixel vertical position
     * @param z Pixel depth
     * @param c Pixel color
     */
    public inline function pixel(x : Int, y : Int, z : Float, c : OddRGB) : Void
    {
        if (z < depthBuffer.get(x, y))
        {
            depthBuffer.set(x, y, z);
            colorBuffer.setPixel(x, y, c);
        }
    }
    
    /**
     * Draws a colored point at (x, y). Does not affect depth buffer.
     * 
     * @param x Pixel horizontal position
     * @param y Pixel vertical position
     * @param c Pixel color
     */
    public inline function point(x : Int, y : Int, c : OddRGB) : Void
    {
        colorBuffer.setPixel(x, y, c);
    }
    
    /**
     * Implementation of Bresenham's line drawing algorithm. Supports
     * linear color interpolation. Does not affect depth buffer.
     * 
     * @param x1 Start point horizontal position
     * @param y1 Start point vertical position
     * @param c1 Start point color
     * @param x2 End point horizontal position
     * @param y2 End point vertical position
     * @param c2 End point color
     */
    public function line(x1 : Int, y1 : Int, c1: OddRGB, x2 : Int, y2 : Int, c2 : OddRGB) : Void
    {
        var x : Int = x1;
        var y : Int = y1;
        
        var dx : Int = Math.round(Math.abs(x2 - x1));
        var dy : Int = Math.round(Math.abs(y2 - y1));
        
        var sx : Int = x1 < x2 ? 1 : -1;
        var sy : Int = y1 < y2 ? 1 : -1;
        
        var e : Float = (dx > dy ? dx : -dy) / 2;
        
        var l : Float = Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
        
        while (x != x2 || y != y2)
        {
            if (c1 == c2)
            {
                colorBuffer.setPixel(x, y, c1);
            }
            else
            {
                var l1 : Float = Math.sqrt((x1 - x) * (x1 - x) + (y1 - y) * (y1 - y));
                var l2 : Float = Math.sqrt((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y));
                var s2 : Float = l1 / l;
                var s1 : Float = l2 / l;
                colorBuffer.setPixel(x, y, OddRGB.RGBc(Std.int(s1 * c1.Ri + s2 * c2.Ri), Std.int(s1 * c1.Gi + s2 * c2.Gi), Std.int(s1 * c1.Bi + s2 * c2.Bi)));
            }
            
            var te : Float = e;
            
            if (te > -dx)
            {
                e -= dy;
                x += sx;
            }
            
            if (te < dy)
            {
                e += dx;
                y += sy;
            }
        }
    }
    
    /**
     * Implementation of midpoint circle algorithm. Does not affect
     * depth buffer.
     * 
     * @param x Origin horizontal position
     * @param y Origin vertical position
     * @param r Circle radius
     * @param color Circle color
     */
    public function circle(x : Int, y : Int, r : Int, color : OddRGB)
    {
        var cx : Int = r;
        var cy : Int = 0;
        var d : Int = 1 - cx;
        
        while (cy <= cx)
        {
            // Quadrant 1
            colorBuffer.setPixel(x + cx, y - cy, color);
            colorBuffer.setPixel(x + cy, y - cx, color);
            // Quadrant 2
            colorBuffer.setPixel(x - cx, y - cy, color);
            colorBuffer.setPixel(x - cy, y - cx, color);
            // Quadrant 3
            colorBuffer.setPixel(x - cx, y + cy, color);
            colorBuffer.setPixel(x - cy, y + cx, color);
            // Quadrant 4
            colorBuffer.setPixel(x + cx, y + cy, color);
            colorBuffer.setPixel(x + cy, y + cx, color);
            
            cy++;
            
            if (d <= 0)
            {
                d += 2 * cy + 1;
            }
            else
            {
                cx--;
                d += 2 * (cy - cx) + 1;
            }
        }
    }
}