package odd.renderers.js;
import haxe.io.BytesData;

@:native('OddCanvasRenderer')
extern class OddCanvasRenderer {
    public function new(width : Int, height : Int);
    public var width(default, null) : Int;
    public var height(default, null) : Int;
    public function render(bufferData : BytesData) : Void;
}