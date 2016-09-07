package odd.rasterizer.pipeline;

import odd.rasterizer.ds.primitives.Triangle;

/**
 * Handles vertex processing.
 */
class VertexProcessor
{
    public static function process(triangle : Triangle, shader : Shader) : Void
    {
        triangle.a.position = shader.vertex(triangle.a.position);
        triangle.b.position = shader.vertex(triangle.b.position);
        triangle.c.position = shader.vertex(triangle.c.position);
    }
}