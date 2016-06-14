package odd;

#if js
typedef Renderer = odd._target.js.Renderer;
#elseif sys
typedef Renderer = odd._target.sys.Renderer;
#else
class Renderer
{
    public function new(width : Int, height : Int);
    public function render(bufferData : haxe.io.BytesData);
}
#end