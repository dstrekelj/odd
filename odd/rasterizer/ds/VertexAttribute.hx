package odd.rasterizer.ds;

/**
 * Known vertex attributes.
 */
enum VertexAttribute 
{
    Color(r : Float, g : Float, b : Float);
    Normal(x : Float, y : Float, z : Float);
    Position(x : Float, y : Float, z : Float, w : Float);
    TextureCoordinate(u : Float, v : Float);
}