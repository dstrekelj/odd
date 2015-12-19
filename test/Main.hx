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
        this.context.setScene(Starfield);
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