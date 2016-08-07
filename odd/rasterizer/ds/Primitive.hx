package odd.rasterizer.ds;

/**
 * Primitive data structure. A primitive can be a point, line, or
 * triangle.
 */
enum Primitive 
{
    Point(a : Vertex);
    Line(a : Vertex, b : Vertex);
    Triangle(a : Vertex, b : Vertex, c : Vertex);
}