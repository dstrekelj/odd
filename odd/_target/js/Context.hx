package odd._target.js;

import js.html.CanvasRenderingContext2D;
import js.html.ImageData;
import js.html.Uint8ClampedArray;
import odd._target.js.FrameBufferData;

class Context
{
    var width : Int;
    var height : Int;
    
    var context2d : CanvasRenderingContext2D;
    var imageData : ImageData;
    
    public function new(width : Int, height : Int)
    {
        trace('-- odd.target.js.Context --');
        
        this.width = width;
        this.height = height;
        
        var document = js.Browser.document;
        var canvas = document.createCanvasElement();
        context2d = canvas.getContext2d();
        canvas.setAttribute('width', Std.string(width));
        canvas.setAttribute('height', Std.string(height));
        document.body.appendChild(canvas);
    }
    
    public function draw(frameBufferData : FrameBufferData) : Void
    {
        imageData = new ImageData(frameBufferData, width, height);
        context2d.putImageData(imageData, 0, 0);
    }
}