package odd;
import odd.renderers.js.CanvasRenderer;
import odd.renderers.js.OddCanvasRenderer;

#if (js && ODD_CANVAS_RENDERER)
typedef Renderer = OddCanvasRenderer;
#else
typedef Renderer = CanvasRenderer;
#end