package;

import odd.math.OddVec2;
import odd.OddContext;
import odd.renderer.OddCanvasRenderer;
import odd.util.OddColor;

class Main extends OddContext
{
    static function main()
    {
        new Main();
    }
    
    public function new()
    {
        super(640, 480, OddColor.RGB(0x000000));
        
        image.line(320, 240, 640, 240, OddColor.RGB(0xff0000));
        image.line(320, 240, 0, 240, OddColor.RGB(0x00ff00));
        image.line(320, 240, 320, 480, OddColor.RGB(0x0000ff));
        image.line(320, 240, 320, 0, OddColor.RGB(0xffffff));
        
        image.circle(320, 240, 50, OddColor.RGB(0xff00ff));
        
        var renderer = new OddCanvasRenderer(640, 480);
        renderer.render(this.image.getData());
    }
}