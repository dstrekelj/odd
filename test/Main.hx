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
        new Main(640, 480, 30);
    }
    
    public function new(width : Int, height : Int, framesPerSecond : Int)
    {
        super(width, height, framesPerSecond);
        this.context.setScene(Test);
        this.run();
    }
}

class Test extends Scene
{
    var point : Point;
    
    override public function create() : Void
    {
        point = { x : 320, y : 240 };
    }
    
    override public function draw() : Void
    {
        super.draw();
        buffer.setPixel(point.x, point.y, 0xffffffff);
    }
    var time : Float = 0;
    override public function update(elapsed : Float) : Void
    {
        time += elapsed * 1000;
        point.x += Std.int(Math.sin(time / 400) * 4);
        point.y += Std.int(Math.cos(time / 400) * 4);
    }
}

typedef Point = {
    x : Int,
    y : Int
}