# odd

Odd is a peculiar little software renderer written in Haxe that aims to be platform agnostic.

The idea is that all of the rendering logic is defined in a cross-platform way, and that the image buffer data is then passed to a user-specified back-end which will handle the drawing of the frame (to a window, canvas, image, ASCII text, etc.).

**Please note that Odd is still under development!**

## Instructions

1. Get [Haxe](http://haxe.org/download/). Any 3.2.x version is likely to work.
2. Get odd: `haxelib git odd https://github.com/dstrekelj/odd.git dev`
3. Run samples!

## Adding your own renderer

The renderer's only job is to draw its idea of a pixel on its idea of a window / canvas. Certain requirements need to be met for the renderer to work.

A sample renderer class should look like this:

```haxe
class MyRenderer
{
    public function new(width : Int, height : Int);
    public function render(bufferData : PLATFORM_SPECIFIC_TYPE);
}
```

Write an extern class for it and put it somewhere in the `odd.renderers` namespace. Update the `odd.Renderer` class with another conditional compilation branch. Add the directive / flag to your buildfile and you're good to go.

The slightly tricky bit is the `bufferData` that is passed to the public `render()` method. What _odd_ is actually passsing is `haxe.io.BytesData`. Usually this is an array of unsigned integers, but it's best to check with the Haxe API for platform specific implementation details.
