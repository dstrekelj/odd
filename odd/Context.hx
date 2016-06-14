package odd;

#if java
typedef Context = odd._target.java.Context;
#elseif js
typedef Context = odd._target.js.Context;
#else
class Context
{
    public function new(width : Int, height : Int) {}
    public function draw(frameBufferData : FrameBufferData) {}
}
#end