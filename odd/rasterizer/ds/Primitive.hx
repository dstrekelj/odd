package odd.rasterizer.ds;

enum Primitive 
{
    Point(a : Vertex);
    Line(a : Vertex, b : Vertex);
    Triangle(a : Vertex, b : Vertex, c : Vertex);
}