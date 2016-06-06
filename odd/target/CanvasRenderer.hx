package odd.target;

import haxe.io.BytesData;
#if js
import js.html.CanvasRenderingContext2D;
import js.html.ImageData;
import js.html.Uint8ClampedArray;
#end
class CanvasRenderer
{
    var width : Int;
    var height : Int;
    #if js
    var context : CanvasRenderingContext2D;
    var pixelArray : Uint8ClampedArray;
    var imageData : ImageData;
    #end
    
    public function new(width : Int, height : Int)
    {
        trace('-- OddCanvasRenderer --');
        
        this.width = width;
        this.height = height;
        #if js
        var document = js.Browser.document;
        var canvas = document.createCanvasElement();
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