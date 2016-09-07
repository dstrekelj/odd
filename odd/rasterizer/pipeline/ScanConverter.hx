package odd.rasterizer.pipeline;

import odd.data.DepthBuffer;
import odd.math.Vec2;
import odd.math.Vec2i;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.rasterizer.Shader;
import odd.rasterizer.ds.primitives.Triangle;
import odd.Framebuffer;

/**
 * Handles the scan conversion of a primitive.
 * 
 * TODO: Implement point and line primitive scan conversion.
 */
class ScanConverter
{
    public static function process(framebuffer : Framebuffer, depthBuffer : DepthBuffer, shader : Shader, triangle : Triangle) : Void
    {
        var haveVerticesDefinedColor = (triangle.a.color != null) || (triangle.b.color != null) || (triangle.c.color != null);
        var haveVerticesDefinedNormal = (triangle.a.normal != null) || (triangle.b.normal != null) || (triangle.c.normal != null);
        var haveVerticesDefinedTextureCoordinate = (triangle.a.textureCoordinate != null) || (triangle.b.textureCoordinate != null) || (triangle.c.textureCoordinate != null); 

        triangle.a.position.z = 1 / triangle.a.position.z;
        triangle.b.position.z = 1 / triangle.b.position.z;
        triangle.c.position.z = 1 / triangle.c.position.z;
        
        if (haveVerticesDefinedColor)
        {
            triangle.a.color *= triangle.a.position.z;
            triangle.b.color *= triangle.b.position.z;
            triangle.c.color *= triangle.c.position.z;
        }
        
        if (haveVerticesDefinedNormal)
        {
            triangle.a.normal *= triangle.a.position.z;
            triangle.b.normal *= triangle.b.position.z;
            triangle.c.normal *= triangle.c.position.z;
        }

        if (haveVerticesDefinedTextureCoordinate)
        {
            triangle.a.textureCoordinate *= triangle.a.position.z;
            triangle.b.textureCoordinate *= triangle.b.position.z;
            triangle.c.textureCoordinate *= triangle.c.position.z;
        }
        
        var min : Vec2i = new Vec2i(
            Math.floor(Math.max(0, Math.min(triangle.a.position.x, Math.min(triangle.b.position.x, triangle.c.position.x)))),
            Math.floor(Math.max(0, Math.min(triangle.a.position.y, Math.min(triangle.b.position.y, triangle.c.position.y))))
        );
        var max : Vec2i = new Vec2i(
            Math.floor(Math.min(framebuffer.width, Math.max(triangle.a.position.x, Math.max(triangle.b.position.x, triangle.c.position.x)))),
            Math.floor(Math.min(framebuffer.height, Math.max(triangle.a.position.y, Math.max(triangle.b.position.y, triangle.c.position.y))))
        );
        
        var p : Vec2 = new Vec2(0, 0);
        var pA : Vec2 = new Vec2(triangle.a.position.x, triangle.a.position.y);
        var pB : Vec2 = new Vec2(triangle.b.position.x, triangle.b.position.y);
        var pC : Vec2 = new Vec2(triangle.c.position.x, triangle.c.position.y);
        
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
                    
                    var z : Float = 1 / (areaP.y * triangle.a.position.z + areaP.z * triangle.b.position.z + areaP.x * triangle.c.position.z);
                    
                    if (z < depthBuffer.get(j, i))
                    {
                        if (haveVerticesDefinedColor)
                        {
                            interpolateColor(shader, z, areaP, triangle);
                        }
                        
                        if (haveVerticesDefinedTextureCoordinate)
                        {
                            interpolateUV(shader, z, areaP, triangle);
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
    
    private static inline function interpolateColor(shader : Shader, z : Float, areaP : Vec3, triangle : Triangle) : Void
    {
        var r = (areaP.y * triangle.a.color.x + areaP.z * triangle.b.color.x + areaP.x * triangle.c.color.x);
        var g = (areaP.y * triangle.a.color.y + areaP.z * triangle.b.color.y + areaP.x * triangle.c.color.y);
        var b = (areaP.y * triangle.a.color.z + areaP.z * triangle.b.color.z + areaP.x * triangle.c.color.z);
        
        shader.fragmentColor.x = r * z;
        shader.fragmentColor.y = g * z;
        shader.fragmentColor.z = b * z;
    }
    
    private static inline function interpolateUV(shader : Shader, z : Float, areaP : Vec3, triangle : Triangle) : Void
    {
        var u = (areaP.y * triangle.a.textureCoordinate.x + areaP.z * triangle.b.textureCoordinate.x + areaP.x * triangle.c.textureCoordinate.x);
        var v = (areaP.y * triangle.a.textureCoordinate.y + areaP.z * triangle.b.textureCoordinate.y + areaP.x * triangle.c.textureCoordinate.y);
        
        shader.fragmentTextureCoordinate.x = u * z;
        shader.fragmentTextureCoordinate.y = v * z;
    }
}