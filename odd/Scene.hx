package odd;
import haxe.Timer;

/**
 * ...
 * @author 
 */
class Scene
{
    public var buffer : ImageBuffer;
    
    var context : Context;
    
    public function new(buffer : ImageBuffer, context : Context) {
        this.buffer = buffer;
        this.context = context;
        
        trace('-- NEW SCENE --');
    }
    
    public function create() : Void {}
   
    public function destroy() : Void {}
    
    public function draw() : Void {}
    
    public function update(delta : Float) : Void {}
}