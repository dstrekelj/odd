package odd.renderers.js;
#if js
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.HTMLDocument;
import js.html.ImageData;
import js.html.Uint8ClampedArray;
#end
import haxe.io.BytesData;
import haxe.Timer;
import odd.ImageBuffer;

/**
 * ...
 * @author 
 */
class CanvasRenderer
{
    #if js
    var context : CanvasRenderingContext2D;
    var pixelArray : Uint8ClampedArray;
    var imageData : ImageData;
    #end
    
    var width : Int;
    var height : Int;
    
    public function new(width : Int, height : Int)
    {
        trace('-- CanvasRenderer --');
        
        this.width = width;
        this.height = height;
        
        #if js
        var document : HTMLDocument = Browser.document;
        var canvas : CanvasElement = document.createCanvasElement();
        context = canvas.getContext2d();
        canvas.setAttribute('width', Std.string(width));
        canvas.setAttribute('height', Std.string(height));
        document.body.appendChild(canvas);
        #end
    }
    
    public function render(bufferData : BytesData) : Void
    {
        #if js
        pixelArray = new Uint8ClampedArray(bufferData);
        imageData = new ImageData(pixelArray, width, height);
        context.putImageData(imageData, 0, 0);
        #end
    }
}