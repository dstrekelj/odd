package odd;
import haxe.Timer;
#if js
import js.Browser;
#end

/**
 * ...
 * @author 
 */
class Engine
{
    var framesPerSecond : Float;
    var timeAccumulator : Float;
    var timeElapsed : Float;
    var timeNow : Float;
    var timeStep : Float;
    var timeThen : Float;
    
    var buffer : ImageBuffer;
    var context : Context;
    var scene : Scene;
    
    public function new(width : Int, height : Int, framesPerSecond : Float)
    {
        this.framesPerSecond = framesPerSecond;
        
        timeStep = 1 / framesPerSecond;
        timeThen = Timer.stamp();
        timeAccumulator = 0;
        
        buffer = new ImageBuffer(width, height);
        context = new Context(buffer);
        
        run();
    }
    
    public function run(?time : Float)
    {
        timeNow = Timer.stamp();
        timeElapsed = timeNow - timeThen;
        timeThen = timeNow;
        
        timeAccumulator += timeElapsed;
        
        if (timeAccumulator >= timeStep) {
            update(timeStep);
            timeAccumulator = 0;
        }
        
        draw(timeElapsed);
        
        #if js
        Browser.window.requestAnimationFrame(run);
        #end
    }
    
    public function update(delta : Float) : Void { }
    public function draw(delta : Float) : Void { } 
}