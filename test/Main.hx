package test;
import odd.Engine;
import odd.Scene;
import samples.Starfield;
import samples.Triangle;

class Main extends Engine
{
    static function main() 
    {
        new Main(200, 100, 60);
    }
    
    public function new(width : Int, height : Int, framesPerSecond : Int)
    {
        super(width, height, framesPerSecond);
        this.context.setScene(Triangle);
        this.run();
    }
}