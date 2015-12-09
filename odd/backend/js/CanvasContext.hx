package odd.backend.js;
#if js
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.HTMLDocument;
import js.html.ImageData;
import js.html.Uint8ClampedArray;
#end
import haxe.Timer;
import odd.ImageBuffer;

/**
 * ...
 * @author 
 */
class CanvasContext
{
    public var drawBuffer : ImageBuffer;
    
    var renderBuffer : ImageBuffer;
    
    
    #if js
    var context : CanvasRenderingContext2D;
    var pixelArray : Uint8ClampedArray;
    var imageData : ImageData;
    #end
    
    public function new(width : Int, height : Int)
    {
        trace('new canvas context');
        
        renderBuffer = new ImageBuffer(width, height);
        drawBuffer = new ImageBuffer(width, height);
        
        #if js
        var document : HTMLDocument = Browser.document;
        var canvas : CanvasElement = document.createCanvasElement();
        context = canvas.getContext2d();
        canvas.setAttribute('width', Std.string(width));
        canvas.setAttribute('height', Std.string(height));
        document.body.appendChild(canvas);
        
        draw();
        #end
    }
    
    var frame : Int = 1;
    var buffer : Int = 1;
    public function draw() : Void
    {
        #if js
        pixelArray = new Uint8ClampedArray(renderBuffer.getData());
        imageData = new ImageData(pixelArray, renderBuffer.width, renderBuffer.height);
        context.putImageData(imageData, 0, 0);
        #end
        swapBuffers();
    }
    
    private function swapBuffers() : Void
    {
        var tempBuffer : ImageBuffer = renderBuffer;
        renderBuffer = drawBuffer;
        drawBuffer = tempBuffer;
        if (buffer > 2) buffer = 1;
    }
}