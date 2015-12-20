package test;
import haxe.Timer;
import odd.Engine;
import odd.ImageBuffer;
import odd.Scene;

/**
 * ...
 * @author
 */
class Main extends Engine
{
    static function main() 
    {
        new Main(800, 600, 60);
    }
    
    public function new(width : Int, height : Int, framesPerSecond : Int)
    {
        super(width, height, framesPerSecond);
        this.context.setScene(Test);
        this.run();
    }
}

typedef Star = {
    x : Float,
    y : Float,
    z : Float
}

class Starfield extends Scene
{
    var spread : Float;
    var speed : Float;
    var stars : Array<Star>;
    
    override public function create() : Void
    {
        super.create();
        spread = 64;
        speed = 32;
        stars = [for (i in 0...256) {
            x : 2 * (Math.random() - 0.5) * spread,
            y : 2 * (Math.random() - 0.5) * spread,
            z : Math.random() * spread
        } ];
    }
    
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
        
        var halfWidth = context.width / 2;
        var halfHeight = context.height / 2;
        
        for (star in stars)
        {
            star.z -= elapsed * speed;
            
            if (star.z <= 0)
            {
                star.x = 2 * (Math.random() - 0.5) * spread;
                star.y = 2 * (Math.random() - 0.5) * spread;
                star.z = Math.random() * spread;
            }
            
            var x = Math.floor((star.x / star.z) * halfWidth + halfWidth);
            var y = Math.floor((star.y / star.z) * halfHeight + halfHeight);
            
            if (x < 0 || x >= context.width || y < 0 || y >= context.height)
            {
                star.x = 2 * (Math.random() - 0.5) * spread;
                star.y = 2 * (Math.random() - 0.5) * spread;
                star.z = Math.random() * spread;
            }
            else
            {
                buffer.setPixel(x, y, 0xffffffff);
            }
        }
    }
    
    override public function draw() : Void
    {
        super.draw();
    }
}

typedef Point = {
    x : Int,
    y : Int
}

class Test extends Scene
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
        
        time = 0;
    }
    
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
        
        time += elapsed;
        
        p2.x = p1.x + Std.int(Math.sin(time) * 100);
        p2.y = p1.y + Std.int(Math.cos(time) * 100);
    }
    
    override public function draw() : Void
    {
        super.draw();
        
        buffer.setPixel(p1.x, p1.y, 0xffffffff);
        buffer.setPixel(p2.x, p2.y, 0xffffffff);
        drawLine(p1, p2);
    }
    
    function drawLine(a : Point, b : Point) : Void
    {
        var p : Point = { x : a.x, y : a.y };
        
        var dx : Int = Math.round(Math.abs(b.x - a.x));
        var dy : Int = Math.round(Math.abs(b.y - a.y));
        
        var sx : Int = a.x < b.x ? 1 : -1;
        var sy : Int = a.y < b.y ? 1 : -1;
        
        var e : Float = (dx > dy ? dx : -dy) / 2;
        
        while (true)
        {
            trace(a.x);
            buffer.setPixel(p.x, p.y, 0xffffffff);
            if (p.x == b.x && p.y == b.y)
            {
                break;
            }
            
            var te = e;
            
            if (te > -dx)
            {
                e -= dy;
                p.x += sx;
            }
            
            if (te < dy)
            {
                e += dx;
                p.y += sy;
            }
        }
    }
}