package odd.rasterizer.pipeline;

import haxe.ds.Vector;

import odd.math.Vec2;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.ds.Vertex;
import odd.rasterizer.Geometry;

/**
 * Handles assembling geometry vertices into appropriate primitives.
 * 
 * TODO: Implement point and line primitive assemblers.
 */
class PrimitiveAssembler
{
    public static function assembleTriangle(indices : Vector<Int>, geometry : Geometry) : Primitive
    {
        var vertices : Vector<Vertex> = new Vector<Vertex>(3);
        
        for (i in 0...indices.length)
        {
            var index = indices[i];
            var vertex = new Vertex();

            vertex.position = new Vec4(
                geometry.positions[index * 3],
                geometry.positions[index * 3 + 1],
                geometry.positions[index * 3 + 2],
                1
            );
            
            if (geometry.colors.length > 0)
            {
                vertex.color = new Vec3(
                    geometry.colors[index * 3],
                    geometry.colors[index * 3 + 1],
                    geometry.colors[index * 3 + 2]
                );
            }
            
            if (geometry.normals.length > 0)
            {
                vertex.normal = new Vec3(
                    geometry.normals[index * 3],
                    geometry.normals[index * 3 + 1],
                    geometry.normals[index * 3 + 2]
                );
            }
            
            if (geometry.textureCoordinates.length > 0)
            {
                vertex.textureCoordinate = new Vec2(
                    geometry.textureCoordinates[index * 2],
                    geometry.textureCoordinates[index * 2 + 1]
                );
            }

            vertices[i] = vertex;
        }
        
        return Primitive.Triangle(vertices[0], vertices[1], vertices[2]);
    }
}