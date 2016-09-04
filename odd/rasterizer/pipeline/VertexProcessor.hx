package odd.rasterizer.pipeline;

import odd.math.Vec2;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.rasterizer.ds.Vertex;
import odd.rasterizer.ds.VertexAttribute;

/**
 * Handles vertex processing.
 */
class VertexProcessor
{
    public static function process(vertex : Vertex, shader : Shader) : Vertex
    {
        var processedVertex : Vertex = [];
        
        for (attribute in vertex)
        {
            switch (attribute)
            {
                case VertexAttribute.Position(x, y, z, w):
                    var p = shader.vertex(new Vec4(x, y, z, w));
                    processedVertex.push(VertexAttribute.Position(p.x, p.y, p.z, p.w));
                case VertexAttribute.Color(r, g, b):
                    shader.vertexColor = new Vec3(r, g, b);
                    processedVertex.push(attribute);
                case VertexAttribute.Normal(x, y, z):
                    shader.vertexNormal = new Vec3(x, y, z);
                    processedVertex.push(attribute);
                case VertexAttribute.TextureCoordinate(u, v):
                    shader.vertexTextureCoordinate = new Vec2(u, v);
                    processedVertex.push(attribute);
            }
        }
        
        return processedVertex;
    }
}