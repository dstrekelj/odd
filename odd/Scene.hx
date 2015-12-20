package odd;
import haxe.Timer;

/**
 * The `Scene` is in charge of what is rendered and updated.
 * It is handled by the context and is put in charge of its
 * own draw buffer.
 * 
 * Extend this to create your own, well, scene. But do not
 * override the constructor! Override the `create()` method
 * instead.
 */
class Scene
{
    /**
     * Draw buffer
     */
    public var buffer : ImageBuffer;
    
    /**
     * Rendering context
     */
    var context : Context;
    
    /**
     * Creates new scene. This is handled by the context, as it is in
     * charge of the render and draw buffers.
     * 
     * @param buffer ImageBuffer to draw to
     * @param context Rendering context (unnecessary?)
     */
    public function new(buffer : ImageBuffer, context : Context) {
        this.buffer = buffer;
        this.context = context;
        
        trace('-- NEW SCENE --');
    }
    
    /**
     * Called on scene creation. Override this.
     */
    public function create() : Void {}
   
    /**
     * Called when scene is changed (destroyed). Override this.
     */
    public function destroy() : Void {}
    
    /**
     * Override this to draw to buffer.
     */
    public function draw() : Void {}
    
    /**
     * Override this to update objects in scene.
     * @param delta Time step (1 / FPS)
     */
    public function update(delta : Float) : Void {}
}