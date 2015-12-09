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
    
    var context : Context;
    
    var scene : Scene;
    
    public function new(width : Int, height : Int, framesPerSecond : Float)
    {
        this.framesPerSecond = framesPerSecond;
        
        timeStep = 1 / framesPerSecond;
        timeThen = Timer.stamp();
        timeAccumulator = 0;
        
        context = new Context(width, height);
    }
    
    public function loadScene(newScene : Class<Scene>) : Void
    {
        scene = Type.createInstance(newScene, [context]);
        scene.create();
    }
    
    public function run(?time : Float)
    {
        timeNow = Timer.stamp();
        timeElapsed = timeNow - timeThen;
        timeThen = timeNow;
        
        timeAccumulator += timeElapsed;
        
        if (timeAccumulator >= timeStep) {
            scene.update(timeStep);
            timeAccumulator = 0;
        }
        
        scene.draw(timeElapsed);
        
        #if js
        Browser.window.requestAnimationFrame(run);
        #end
    }
}