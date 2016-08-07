package odd.rasterizer;

import odd.math.Mat4x4;
import odd.math.Vec2;
import odd.math.Vec2i;
import odd.math.Vec3;
import odd.math.Vec4;

/**
 * A shader class should define vertex and fragment
 * shading functions.
 */
class Shader 
{
    @:allow(odd.rasterizer.Pipeline)
    var transformModel : Mat4x4;
    @:allow(odd.rasterizer.Pipeline)
    var transformView : Mat4x4;
    
    @:allow(odd.rasterizer.stages.VertexProcessor)
    var vertexColor : Vec3;
    @:allow(odd.rasterizer.stages.VertexProcessor)
    var vertexNormal : Vec3;
    @:allow(odd.rasterizer.stages.VertexProcessor)
    var vertexTextureCoordinate : Vec2;
    
    @:allow(odd.rasterizer.stages.ScanConverter)
    var fragmentColor : Vec3;
    @:allow(odd.rasterizer.stages.ScanConverter)
    var fragmentTextureCoordinate : Vec2;
    
    public function new()
    {
        // Stub
    }
    
    public function vertex(position : Vec4) : Vec4
    {
        return position;
    }
    
    public function fragment(fragCoord : Vec4, frontFacing : Bool, pointCoord : Vec2i) : Bool
    {
        return false;
    }
}
