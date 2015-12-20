package odd;

/**
 * The `Context` handles the renderer and scene, as well as
 * the render and draw buffers. There can only be one
 * context, and that context is created and handled by the
 * `Engine`.
 */
class Context
{
    /**
     * Width of context
     */
    public var width : Int;
    /**
     * Height of context
     */
    public var height : Int;
    
    /**
     * Platform-specific renderer
     */
    var renderer : Renderer;
    /**
     * Current scene
     */
    var scene : Scene;
    /**
     * Buffer that is rendered by renderer
     */
    var renderBuffer : ImageBuffer;
    /**
     * Buffer that is drawn to by scene
     */
    var drawBuffer : ImageBuffer;

    /**
     * Creates new context.
     * 
     * @param width Width of context
     * @param height Height of context
     */
    public function new(width : Int, height : Int) 
    {
        this.width = width;
        this.height = height;
        
        renderBuffer = new ImageBuffer(width, height);
        drawBuffer = new ImageBuffer(width, height);
        
        renderer = new Renderer(width, height);
    }
    
    /**
     * Updates current scene in context.
     * 
     * @param step Time step (1 / FPS)
     */
    public function update(step : Float) : Void
    {
        if (scene != null) {
            scene.update(step);
        }
    }
    
    /**
     * Draws and renders current scene.
     */
    public function draw() : Void
    {
        scene.draw();
        swapBuffers();
        drawBuffer.clear();
        scene.buffer = drawBuffer;
        renderer.render(renderBuffer.getData());
    }
    
    /**
     * Sets current scene to a different one.
     * 
     * @param scene New scene to make current
     */
    public function setScene(scene : Class<Scene>) : Void
    {
        if (this.scene != null) {
            this.scene.destroy();
        }
        this.scene = Type.createInstance(scene, [drawBuffer, this]);
        this.scene.create();
    }
    
    /**
     * Swaps render and draw buffer.
     */
    private function swapBuffers() : Void
    {
        var tempBuffer : ImageBuffer = renderBuffer;
        renderBuffer = drawBuffer;
        drawBuffer = tempBuffer;
    }
}