package odd.rasterizer.ds;

enum VertexAttribute 
{
    Color(r : Float, g : Float, b : Float);
    Normal(x : Float, y : Float, z : Float);
    Position(x : Float, y : Float, z : Float, w : Float);
    TextureCoordinate(u : Float, v : Float);
}