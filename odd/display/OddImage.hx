package odd.display;

import odd.math.OddVec2;
import odd.util.color.OddRGB;

class OddImage extends OddImageBuffer
{
    public function new(width : Int, height : Int, clearColor : OddRGB)
    {
        super(width, height, clearColor);
    }
    
    public inline function point(x : Int, y : Int, color : OddRGB) : Void
    {
        this.setPixel(x, y, color);
    }
    
    /**
     * Implementation of Bresenham's line drawing algorithm.
     * @param x1 X-coordinate of start point
     * @param y1 Y-coordinate of start point
     * @param x2 X-coordinate of end point
     * @param y2 Y-coordinate of end point
     * @param color Color
     */
    public function line(x1 : Int, y1 : Int, x2 : Int, y2 : Int, c1 : OddRGB, c2 : OddRGB) : Void
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
                this.setPixel(x, y, c1);
            }
            else
            {
                var l1 : Float = Math.sqrt((x1 - x) * (x1 - x) + (y1 - y) * (y1 - y));
                var l2 : Float = Math.sqrt((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y));
                var s2 : Float = l1 / l;
                var s1 : Float = l2 / l;
                this.setPixel(x, y, OddRGB.RGBc(Std.int(s1 * c1.Ri + s2 * c2.Ri), Std.int(s1 * c1.Gi + s2 * c2.Gi), Std.int(s1 * c1.Bi + s2 * c2.Bi)));
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
     * Implementation of midpoint circle algorithm.
     * @param x X-coordinate of circle origin
     * @param y Y-coordinate of circle origin
     * @param r Radius of circle
     * @param color Color
     */
    public function circle(x : Int, y : Int, r : Int, color : OddRGB)
    {
        var cx : Int = r;
        var cy : Int = 0;
        var d : Int = 1 - cx;
        
        while (cy <= cx)
        {
            // Quadrant 1
            this.setPixel(x + cx, y - cy, color);
            this.setPixel(x + cy, y - cx, color);
            // Quadrant 2
            this.setPixel(x - cx, y - cy, color);
            this.setPixel(x - cy, y - cx, color);
            // Quadrant 3
            this.setPixel(x - cx, y + cy, color);
            this.setPixel(x - cy, y + cx, color);
            // Quadrant 4
            this.setPixel(x + cx, y + cy, color);
            this.setPixel(x + cy, y + cx, color);
            
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