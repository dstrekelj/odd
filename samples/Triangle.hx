package samples;
import odd.Scene;

typedef Point = {
    x : Int,
    y : Int
}

class Triangle extends Scene
{
    var p1 : Point;
    var p2 : Point;
    var p3 : Point;
    
    var time : Float;
    
    override public function create() : Void
    {
        super.create();
        
        p1 = { x : Std.int(context.width / 2), y : Std.int(context.height / 2) };
        p2 = { x : 0, y : 0 };
        p3 = { x : 0, y : 0 };
        
        time = 0;
    }
    
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
        
        time += elapsed;
        
        p2.x = p1.x + Std.int(Math.sin(time) * 100);
        p2.y = p1.y + Std.int(Math.cos(time) * 100);
        
        p3.x = p1.x + Std.int(Math.sin(time * 2) * 100);
        p3.y = p1.y + Std.int(Math.cos(time * 2) * 100);
    }
    
    override public function draw() : Void
    {
        super.draw();
        
        drawLine(p1, p2);
        drawLine(p2, p3);
        drawLine(p3, p1);
    }
    
    function drawLine(a : Point, b : Point) : Void
    {
        var x : Int = a.x;
        var y : Int = a.y;
        
        var dx : Int = Math.round(Math.abs(b.x - a.x));
        var dy : Int = Math.round(Math.abs(b.y - a.y));
        
        var sx : Int = a.x < b.x ? 1 : -1;
        var sy : Int = a.y < b.y ? 1 : -1;
        
        var e : Float = (dx > dy ? dx : -dy) / 2;
        
        while (true)
        {
            buffer.setPixel(x, y, 0xffffffff);
            if (x == b.x && y == b.y)
            {
                break;
            }
            
            var te = e;
            
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
}