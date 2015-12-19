package odd;

class Context
{
    public var width : Int;
    public var height : Int;
    
    var renderer : Renderer;
    var scene : Scene;
    
    var renderBuffer : ImageBuffer;
    var drawBuffer : ImageBuffer;

    public function new(width : Int, height : Int) 
    {
        this.width = width;
        this.height = height;
        
        renderBuffer = new ImageBuffer(width, height);
        drawBuffer = new ImageBuffer(width, height);
        
        renderer = new Renderer(width, height);
    }
    
    public function update(step : Float) : Void
    {
        if (scene != null) {
            scene.update(step);
        }
    }
    
    public function draw() : Void
    {
        scene.draw();
        swapBuffers();
        drawBuffer.clear();
        scene.buffer = drawBuffer;
        renderer.render(renderBuffer.getData());
    }
    
    public function setScene(scene : Class<Scene>) : Void
    {
        if (this.scene != null) {
            this.scene.destroy();
        }
        this.scene = Type.createInstance(scene, [drawBuffer, this]);
        this.scene.create();
    }
    
    private function swapBuffers() : Void
    {
        var tempBuffer : ImageBuffer = renderBuffer;
        renderBuffer = drawBuffer;
        drawBuffer = tempBuffer;
    }
}