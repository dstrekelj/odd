package odd.rasterizer.pipeline;

import haxe.ds.Vector;

import odd.rasterizer.ds.Primitive;

/**
 * Handles vertex processing.
 */
class VertexProcessor
{
    public static function process(primitives : Vector<Primitive>, shader : Shader) : Void
    {
        switch (primitives[0])
        {
            case Primitive.Line(a, b):
                a.position = shader.vertex(a.position);
                b.position = shader.vertex(b.position);
                primitives[0] = Primitive.Line(a, b);
            case Primitive.Point(a):
                a.position = shader.vertex(a.position);
                primitives[0] = Primitive.Point(a);
            case Primitive.Triangle(a, b, c):
                a.position = shader.vertex(a.position);
                b.position = shader.vertex(b.position);
                c.position = shader.vertex(c.position);
                primitives[0] = Primitive.Triangle(a, b, c);
        }
    }
}