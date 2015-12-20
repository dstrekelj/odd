package odd;
import haxe.Timer;
#if js
import js.Browser;
#end

/**
 * Odd Software Renderer.
 * 
 * This is the engine - the driving force behind the renderer.
 * Your main class should extended it, or at the very least
 * handle its instantiation.
 * 
 * The `Engine` handles the run loop, which updates and renders
 * the scene attached to the current context.
 * 
 * Don't forget to set the scene in the context and then run
 * the engine!
 */
class Engine
{
    /**
     * Desired frame rate, in number of frames to be drawn per second
     */
    var framesPerSecond : Float;
    /**
     * Fill it up with time and empty it once it's overflowing
     */
    var timeAccumulator : Float;
    /**
     * Time elapsed between current and previous frame (now and then)
     */
    var timeElapsed : Float;
    /**
     * Current time stamp (now)
     */
    var timeNow : Float;
    /**
     * Maximum allowed timestep, defined as 1 / framesPerSecond
     */
    var timeStep : Float;
    /**
     * Previous time stamp (then)
     */
    var timeThen : Float;
    /**
     * Current rendering context (handles scene and renderer, i.e. update and draw calls)
     */
    var context : Context;
    
    /**
     * Create new instance of the Odd software rendering engine.
     * 
     * @param width Width of context / screen
     * @param height Height of context / screen
     * @param framesPerSecond Desired frames per second
     */
    public function new(width : Int, height : Int, framesPerSecond : Float)
    {
        this.framesPerSecond = framesPerSecond;
        
        timeStep = 1 / framesPerSecond;
        timeThen = Timer.stamp();
        timeAccumulator = 0;
        
        context = new Context(width, height);
    }
    
    /**
     * Starts the render loop.
     * 
     * @param time Required for the JS rendering loop. You can disregard it
     */
    public function run(?time : Float)
    {
        timeNow = Timer.stamp();
        timeElapsed = timeNow - timeThen;
        timeThen = timeNow;
        
        timeAccumulator += timeElapsed;
        
        if (timeAccumulator >= timeStep) {
            context.update(timeStep);
            timeAccumulator = 0;
        }
        
        context.draw();
        
        #if js
        Browser.window.requestAnimationFrame(run);
        #else
        while (true) {
            run();
        }
        #end
    }
}