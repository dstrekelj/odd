package odd;
import odd.display.OddImage;
import odd.geom.OddMesh;
import odd.render.OddPipeline;
import odd.util.color.OddRGB;

class OddContext
{
    public var width(default, null) : Int;
    public var height(default, null) : Int;
    public var image(default, null) : OddImage;
    
    public function new(width : Int, height : Int, clearColor : OddRGB) 
    {
        this.width = width;
        this.height = height;
        this.image = new OddImage(width, height, clearColor);
        
        OddPipeline.init(width, height, image);
    }
    
    public inline function render(mesh : OddMesh) : Void
    {
        OddPipeline.run(mesh);
    }
}