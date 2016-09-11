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
        // Determine triangle bounding box area within framebuffer dimensions
        var min : Vec2i = new Vec2i(
            Math.floor(Math.max(0, Math.min(triangle.a.position.x, Math.min(triangle.b.position.x, triangle.c.position.x)))),
            Math.floor(Math.max(0, Math.min(triangle.a.position.y, Math.min(triangle.b.position.y, triangle.c.position.y))))
        );
        var max : Vec2i = new Vec2i(
            Math.floor(Math.min(framebuffer.width, Math.max(triangle.a.position.x, Math.max(triangle.b.position.x, triangle.c.position.x)))),
            Math.floor(Math.min(framebuffer.height, Math.max(triangle.a.position.y, Math.max(triangle.b.position.y, triangle.c.position.y))))
        );
        
        // Extract projected locations of triangle points
        var pA : Vec2 = new Vec2(triangle.a.position.x, triangle.a.position.y);
        var pB : Vec2 = new Vec2(triangle.b.position.x, triangle.b.position.y);
        var pC : Vec2 = new Vec2(triangle.c.position.x, triangle.c.position.y);
        // Calculate triangle area
        var areaABC : Float = edge(pA, pB, pC);

        // Track fragment sample point within triangle bounding box
        var p : Vec2 = new Vec2(0, 0);
        // Track area of triangles formed by sample and two triangle points
        var areaP : Vec3 = new Vec3(0, 0, 0);
        
        var fragmentCoordinate : Vec4 = new Vec4(0, 0, 0, 1);
        var pixelCoordinate : Vec2i = new Vec2i(0, 0);
        
        var y = min.y;
        var x = min.x;
        while (y <= max.y)
        {
            p.y = y + 0.5;
            
            x = min.x;
            while (x <= max.x)
            {
                p.x = x + 0.5;
                
                areaP.x = edge(pB, pC, p);
                areaP.y = edge(pC, pA, p);
                areaP.z = edge(pA, pB, p);

                if (areaP.x >= 0 && areaP.y >= 0 && areaP.z >= 0)
                {
                    areaP /= areaABC;

                    var z : Float = 1 / (areaP.x * triangle.a.position.z + areaP.y * triangle.b.position.z + areaP.z * triangle.c.position.z);
                    
                    if (1 / z == 0)
                    {
                        z = 0;
                    }
                    
                    if (!Math.isFinite(z) || z < 0 || z > 1)
                    {
                        x += 1;
                        continue;
                    }

                    var w : Float = 1 / (areaP.x * triangle.a.position.w + areaP.y * triangle.b.position.w + areaP.z * triangle.c.position.w);

                    if (z <= depthBuffer.get(x, y))
                    {
                        interpolateAttributes(triangle, z, w, areaP, shader);
                        
                        fragmentCoordinate.x = p.x;
                        fragmentCoordinate.y = p.y;
                        fragmentCoordinate.z = 1 / z;
                        fragmentCoordinate.w = 1 / w;

                        pixelCoordinate.x = x;
                        pixelCoordinate.y = framebuffer.height - y;
                        
                        if (shader.fragment(fragmentCoordinate, pixelCoordinate))
                        {
                            depthBuffer.set(x, y, z);
                            var color = odd.Color.RGBf(shader.fragmentColor.x, shader.fragmentColor.y, shader.fragmentColor.z);
                            framebuffer.setPixel(pixelCoordinate.x, pixelCoordinate.y, color);
                        }
                    }
                }
                
                x += 1;
            }
            
            y += 1;
        }
    }

    static inline function edge(a : Vec2, b : Vec2, p : Vec2) : Float
    {
        return p.x * (a.y - b.y) + p.y * (b.x - a.x) + (a.x * b.y - a.y * b.x);
    }

    static inline function interpolateAttributes(triangle : Triangle, z : Float, w : Float, areaP : Vec3, shader : Shader) : Void
    {
        if (triangle.hasColorAttribute()) interpolateColor(triangle, w, areaP, shader);
        if (triangle.hasTextureCoordinateAttribute()) interpolateUV(triangle, w, areaP, shader);
    }
    
    static inline function interpolateColor(triangle : Triangle, w : Float, areaP : Vec3, shader : Shader) : Void
    {
        //trace(Std.string(areaP), w, 1 / w);

        var r = (areaP.x * triangle.a.color.x + areaP.y * triangle.b.color.x + areaP.z * triangle.c.color.x);
        var g = (areaP.x * triangle.a.color.y + areaP.y * triangle.b.color.y + areaP.z * triangle.c.color.y);
        var b = (areaP.x * triangle.a.color.z + areaP.y * triangle.b.color.z + areaP.z * triangle.c.color.z);
        
        shader.fragmentColor.x = r * w;
        shader.fragmentColor.y = g * w;
        shader.fragmentColor.z = b * w;
    }
    
    static inline function interpolateUV(triangle : Triangle, w : Float, areaP : Vec3, shader : Shader) : Void
    {
        var u = (areaP.x * triangle.a.textureCoordinate.x + areaP.y * triangle.b.textureCoordinate.x + areaP.z * triangle.c.textureCoordinate.x);
        var v = (areaP.x * triangle.a.textureCoordinate.y + areaP.y * triangle.b.textureCoordinate.y + areaP.z * triangle.c.textureCoordinate.y);

        shader.fragmentTextureCoordinate.x = u * w;
        shader.fragmentTextureCoordinate.y = v * w;
    }
}