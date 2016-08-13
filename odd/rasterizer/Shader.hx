package odd.rasterizer;

import odd.math.Mat4x4;
import odd.math.Vec2;
import odd.math.Vec2i;
import odd.math.Vec3;
import odd.math.Vec4;

/**
 * Base shader class, defining vertex and fragment shading methods.
 * Different stages of the rasterization pipeline have write access
 * to different vertex / fragment variables.
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
        fragmentColor = new Vec3(0, 0, 0);
        fragmentTextureCoordinate = new Vec2(0, 0);
    }
    
    public function vertex(position : Vec4) : Vec4
    {
        return position;
    }
    
    /**
     * Fragment shader.
     * 
     * @param fragCoord
     * @param frontFacing
     * @param pointCoord
     * @return `true` to keep the fragment, `false` to discard it
     */
    public function fragment(fragCoord : Vec4, frontFacing : Bool, pointCoord : Vec2i) : Bool
    {
        return true;
    }
}
