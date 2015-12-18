# odd

Odd is a peculiar little software renderer written in Haxe that aims to be renderer / platform agnostic.

The idea is that all of the rendering logic is defined in a cross-platform way, and that the image buffer data is then passed to a user-specified back-end which will handle the drawing of the frame (to a window, canvas, image, ASCII text, etc.).
