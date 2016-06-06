package odd;
import odd.display.Image;
import odd.geom.Mesh;
import odd.render.Pipeline;
import odd.util.color.RGB;

class Context
{
    public var width(default, null) : Int;
    public var height(default, null) : Int;
    public var image(default, null) : Image;
    
    public function new(width : Int, height : Int, clearColor : RGB) 
    {
        this.width = width;
        this.height = height;
        this.image = new Image(width, height, clearColor);
        
        Pipeline.init(width, height, image);
    }
    
    public inline function render(mesh : Mesh) : Void
    {
        Pipeline.run(mesh);
    }
}