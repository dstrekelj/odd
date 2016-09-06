package odd.rasterizer.pipeline;

import odd.data.DepthBuffer;
import odd.math.Vec2;
import odd.math.Vec2i;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.rasterizer.Shader;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.ds.Vertex;
import odd.Framebuffer;

/**
 * Handles the scan conversion of a primitive.
 * 
 * TODO: Implement point and line primitive scan conversion.
 */
class ScanConverter
{
    public static function process(framebuffer : Framebuffer, depthBuffer : DepthBuffer, shader : Shader, primitive : Primitive) : Void
    {
        switch (primitive)
        {
            case Primitive.Triangle(a, b, c):
                processTriangle(framebuffer, depthBuffer, shader, a, b, c);
            case _:
        }
    }
    
    private static function processTriangle(framebuffer : Framebuffer, depthBuffer : DepthBuffer, shader : Shader, a : Vertex, b : Vertex, c : Vertex) : Void
    {
        trace("...Process triangle");
        var haveVerticesDefinedColor = (a.color != null) || (b.color != null) || (c.color != null);
        var haveVerticesDefinedNormal = (a.normal != null) || (b.normal != null) || (c.normal != null);
        var haveVerticesDefinedTextureCoordinate = (a.textureCoordinate != null) || (b.textureCoordinate != null) || (c.textureCoordinate != null); 

        a.position.z = 1 / a.position.z;
        b.position.z = 1 / b.position.z;
        c.position.z = 1 / c.position.z;
        
        if (haveVerticesDefinedColor)
        {
            a.color *= a.position.z;
            b.color *= b.position.z;
            c.color *= c.position.z;
        }
        
        if (haveVerticesDefinedNormal)
        {
            a.normal *= a.position.z;
            b.normal *= b.position.z;
            c.normal *= c.position.z;
        }

        if (haveVerticesDefinedTextureCoordinate)
        {
            a.textureCoordinate *= a.position.z;
            b.textureCoordinate *= b.position.z;
            c.textureCoordinate *= c.position.z;
        }
        
        var min : Vec2i = new Vec2i(
            Math.floor(Math.max(0, Math.min(a.position.x, Math.min(b.position.x, c.position.x)))),
            Math.floor(Math.max(0, Math.min(a.position.y, Math.min(b.position.y, c.position.y))))
        );
        var max : Vec2i = new Vec2i(
            Math.floor(Math.min(framebuffer.width, Math.max(a.position.x, Math.max(b.position.x, c.position.x)))),
            Math.floor(Math.min(framebuffer.height, Math.max(a.position.y, Math.max(b.position.y, c.position.y))))
        );
        
        var p : Vec2 = new Vec2(0, 0);
        var pA : Vec2 = new Vec2(a.position.x, a.position.y);
        var pB : Vec2 = new Vec2(b.position.x, b.position.y);
        var pC : Vec2 = new Vec2(c.position.x, c.position.y);
        
        var areaABC : Float = edge(pA.x, pA.y, pB.x, pB.y, pC.x, pC.y);
        var areaP : Vec3 = new Vec3(0, 0, 0);
        
        var fragmentCoordinate : Vec4 = new Vec4(0, 0, 0, 1);
        var pixelCoordinate : Vec2i = new Vec2i(0, 0);
        
        var i = min.y;
        var j = min.x;
        while (i <= max.y)
        {
            p.y = i + 0.5;
            
            j = min.x;
            while (j <= max.x)
            {
                p.x = j + 0.5;
                
                areaP.x = edge(pA.x, pA.y, pB.x, pB.y, p.x, p.y);
                areaP.y = edge(pB.x, pB.y, pC.x, pC.y, p.x, p.y);
                areaP.z = edge(pC.x, pC.y, pA.x, pA.y, p.x, p.y);
                
                // Note: counter-clockwise winding order has negative area
                
                if (areaP.x <= 0 && areaP.y <= 0 && areaP.z <= 0)
                {
                    areaP /= areaABC;
                    
                    var z : Float = 1 / (areaP.y * a.position.z + areaP.z * b.position.z + areaP.x * c.position.z);
                    
                    if (z < depthBuffer.get(j, i))
                    {
                        if (haveVerticesDefinedColor)
                        {
                            interpolateColor(shader, z, areaP, a.color, b.color, c.color);
                        }
                        
                        if (haveVerticesDefinedTextureCoordinate)
                        {
                            interpolateUV(shader, z, areaP, a.textureCoordinate, b.textureCoordinate, c.textureCoordinate);
                        }
                        
                        fragmentCoordinate.x = p.x;
                        fragmentCoordinate.y = p.y;
                        fragmentCoordinate.z = z;
                        
                        pixelCoordinate.x = j;
                        pixelCoordinate.y = i;
                        
                        if (shader.fragment(fragmentCoordinate, pixelCoordinate))
                        {
                            depthBuffer.set(j, i, z);
                            var color = odd.Color.RGBf(shader.fragmentColor.x, shader.fragmentColor.y, shader.fragmentColor.z);
                            framebuffer.setPixel(j, i, color);
                        }
                    }
                }
                
                j++;
            }
            
            i++;
        }
    }
    
    private static inline function edge(ax : Float, ay : Float, bx : Float, by : Float, px : Float, py : Float) : Float
    {
        return px * (ay - by) + py * (bx - ax) + (ax * by - ay * bx);
    }
    
    private static inline function interpolateColor(shader : Shader, z : Float, areaP : Vec3, aCol : Vec3, bCol : Vec3, cCol : Vec3) : Void
    {
        var r = (areaP.y * aCol.x + areaP.z * bCol.x + areaP.x * cCol.x);
        var g = (areaP.y * aCol.y + areaP.z * bCol.y + areaP.x * cCol.y);
        var b = (areaP.y * aCol.z + areaP.z * bCol.z + areaP.x * cCol.z);
        
        shader.fragmentColor.x = r * z;
        shader.fragmentColor.y = g * z;
        shader.fragmentColor.z = b * z;
    }
    
    private static inline function interpolateUV(shader : Shader, z : Float, areaP : Vec3, aUV : Vec2, bUV : Vec2, cUV : Vec2) : Void
    {
        var u = (areaP.y * aUV.x + areaP.z * bUV.x + areaP.x * cUV.x);
        var v = (areaP.y * aUV.y + areaP.z * bUV.y + areaP.x * cUV.y);
        
        shader.fragmentTextureCoordinate.x = u * z;
        shader.fragmentTextureCoordinate.y = v * z;
    }
}