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
    var buffer : ImageBuffer;
    
    #if js
    var context : CanvasRenderingContext2D;
    var pixelArray : Uint8ClampedArray;
    var imageData : ImageData;
    #end
    
    public function new(buffer : ImageBuffer)
    {
        trace('new canvas context');
        this.buffer = buffer;
        
        #if js
        createContext();
        draw();
        #end
    }
    
    #if js
    public function draw() : Void
    {
        pixelArray = new Uint8ClampedArray(buffer.getData());
        imageData = new ImageData(pixelArray, buffer.width, buffer.height);
        context.putImageData(imageData, 0, 0);
    }
    
    public function setBuffer(buffer : ImageBuffer) : Void
    {
        this.buffer = buffer;
    }
    
    private function createContext() : Void
    {
        var document : HTMLDocument = Browser.document;
        var canvas : CanvasElement = document.createCanvasElement();
        context = canvas.getContext2d();
        canvas.setAttribute('width', Std.string(buffer.width));
        canvas.setAttribute('height', Std.string(buffer.height));
        document.body.appendChild(canvas);
    }
    #end
}