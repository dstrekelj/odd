package odd.rasterizer.stages;

import odd.geom.Geometry;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.ds.Vertex;
import odd.rasterizer.ds.VertexAttribute;

class PrimitiveAssembler
{
    public static function assembleTriangle(indices : Array<Int>, geometry : Geometry) : Primitive
    {
        var vertices : Array<Vertex> = [];
        
        for (i in indices)
        {
            var vertex : Vertex = [];
            
            vertex.push(VertexAttribute.Position(
                geometry.positions[i * 3],
                geometry.positions[i * 3 + 1],
                geometry.positions[i * 3 + 2],
                1
            ));
            
            if (geometry.colors.length > 0)
            {
                vertex.push(VertexAttribute.Color(
                    geometry.colors[i * 3],
                    geometry.colors[i * 3 + 1],
                    geometry.colors[i * 3 + 2]
                ));
            }
            
            if (geometry.normals.length > 0)
            {
                vertex.push(VertexAttribute.Normal(
                    geometry.normals[i * 3],
                    geometry.normals[i * 3 + 1],
                    geometry.normals[i * 3 + 2]
                ));
            }
            
            if (geometry.textureCoordinates.length > 0)
            {
                vertex.push(VertexAttribute.TextureCoordinate(
                    geometry.textureCoordinates[i * 2],
                    geometry.textureCoordinates[i * 2 + 1]
                ));
            }
            
            vertices.push(vertex);
        }
        
        return Primitive.Triangle(vertices[0], vertices[1], vertices[2]);
    }
}