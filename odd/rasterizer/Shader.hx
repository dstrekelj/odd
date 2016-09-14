package odd.rasterizer;

import odd.math.Mat4x4;
import odd.math.Vec2;
import odd.math.Vec2i;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.Texture;

/**
 * Base shader class, defining vertex and fragment shading methods.
 * Different stages of the rasterization pipeline have write access
 * to different vertex / fragment variables.
 */
class Shader 
{
    @:allow(odd.rasterizer.pipeline.Pipeline)
    var triangleId : Int;

    @:allow(odd.rasterizer.pipeline.Pipeline)
    var transformModel : Mat4x4;
    @:allow(odd.rasterizer.pipeline.Pipeline)
    var transformView : Mat4x4;
    @:allow(odd.rasterizer.pipeline.Pipeline)
    var transformProjection : Mat4x4;
    @:allow(odd.rasterizer.pipeline.Pipeline)
    var texture : Texture;
    
    @:allow(odd.rasterizer.pipeline.VertexProcessor)
    var vertexColor : Vec3;
    @:allow(odd.rasterizer.pipeline.VertexProcessor)
    var vertexNormal : Vec3;
    @:allow(odd.rasterizer.pipeline.VertexProcessor)
    var vertexTextureCoordinate : Vec2;
    
    @:allow(odd.rasterizer.pipeline.ScanConverter)
    var fragmentColor : Vec3;
    @:allow(odd.rasterizer.pipeline.ScanConverter)
    var fragmentTextureCoordinate : Vec2;
    
    public function new()
    {
        fragmentColor = new Vec3(1, 1, 1);
        fragmentTextureCoordinate = new Vec2(0, 0);
    }
    
    public function vertex(position : Vec4) : Vec4
    {
        position.w = 1;
        return position;
    }
    
    /**
     * Fragment shader.
     * 
     * @param fragCoord
     * @param pointCoord
     * @return `true` to keep the fragment, `false` to discard it
     */
    public function fragment(fragCoord : Vec4, pointCoord : Vec2i) : Bool
    {
        return true;
    }
}
