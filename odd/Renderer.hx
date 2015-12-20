package odd;
import odd.renderers.js.CanvasRenderer;
import odd.renderers.js.OddCanvasRenderer;
import odd.renderers.neko.NekoAsciiRenderer;

#if (js && ODD_CANVAS_RENDERER)
typedef Renderer = OddCanvasRenderer;
#elseif (neko)
typedef Renderer = NekoAsciiRenderer;
#else
typedef Renderer = CanvasRenderer;
#end