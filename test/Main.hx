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
        new Main(320, 240, 30);
    }
    
    public function new(width : Int, height : Int, framesPerSecond : Int)
    {
        super(width, height, framesPerSecond);
        this.loadScene(Test);
        this.run();
    }
}

class Test extends Scene
{
    var point : Point;
    
    override public function create() : Void
    {
        trace('Scene created.');
        point = { x : 0, y : 0 };
    }
    
    override public function draw(elapsed : Float) : Void
    {
        super.draw(elapsed);
        context.drawBuffer.setPixel(point.x, point.y, 0xffffffff);
    }
    
    override public function update(elapsed : Float) : Void
    {
        point.x += 1;
        point.y += 1;
    }
}

typedef Point = {
    x : Int,
    y : Int
}