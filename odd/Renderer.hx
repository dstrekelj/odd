package odd;
import odd.renderers.js.CanvasRenderer;
import odd.renderers.js.OddCanvasRenderer;
import odd.renderers.neko.NekoAsciiRenderer;

/**
 * The `Renderer` changes depending on platform and compiler
 * directives, hence the typedef.
 * 
 * If you made your own renderer, add another conditional
 * and typedef.
 * 
 * Don't forget that a render needs to have a public render()
 * method!
 */

#if (js && ODD_CANVAS_RENDERER)
typedef Renderer = OddCanvasRenderer;
#elseif (neko)
typedef Renderer = NekoAsciiRenderer;
#else
typedef Renderer = CanvasRenderer;
#end