package odd;
import haxe.Timer;

/**
 * ...
 * @author 
 */
class Scene
{
    var context : Context;
    
    public function new(context : Context) {
        this.context = context;
    }
    
    public function create() : Void {}
   
    public function destroy() : Void {}
    
    public function draw(delta : Float) : Void {
        context.draw();
        context.drawBuffer.clear();
    }
    
    public function update(delta : Float) : Void {
    }
}