package samples;
import odd.Engine;
import odd.Scene;

class Main extends Engine
{
    static function main() 
    {
        new Main(800, 600, 60);
    }
    
    public function new(width : Int, height : Int, framesPerSecond : Int)
    {
        super(width, height, framesPerSecond);
        this.context.setScene(FilledTriangle);
        this.run();
    }
}