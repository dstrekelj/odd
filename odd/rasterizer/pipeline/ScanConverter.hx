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

                    // Interpolate vertex position 1 / z, where z = [0, 1]
                    var z : Float = (areaP.x * triangle.a.position.z + areaP.y * triangle.b.position.z + areaP.z * triangle.c.position.z);
                    // Vertex position z, where z = [0, 1]
                    var z_ : Float = 1 / z;
                    
                    // Handle the case of division by zero
                    if (z == 0)
                    {
                        z_ = 0;
                    }
                    
                    // Skip if 1 / z is infinite or not in [0, 1] range
                    if (!Math.isFinite(z_) || (z_ < 0 || z_ > 1))
                    {
                        x += 1;
                        continue;
                    }

                    // Interpolate vertex position 1 / w
                    var w : Float = (areaP.x * triangle.a.position.w + areaP.y * triangle.b.position.w + areaP.z * triangle.c.position.w);
                    var w_ : Float = 1 / w;

                    if (z_ <= depthBuffer.get(x, y))
                    {
                        interpolateAttributes(triangle, w_, areaP, shader);
                        
                        fragmentCoordinate.x = p.x;
                        fragmentCoordinate.y = p.y;
                        fragmentCoordinate.z = z_;
                        fragmentCoordinate.w = w_;

                        pixelCoordinate.x = x;
                        pixelCoordinate.y = framebuffer.height - y;
                        
                        if (shader.fragment(fragmentCoordinate, pixelCoordinate))
                        {
                            depthBuffer.set(x, y, z_);
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

    static inline function interpolateAttributes(triangle : Triangle, w : Float, areaP : Vec3, shader : Shader) : Void
    {
        if (triangle.hasColorAttribute()) interpolateColor(triangle, w, areaP, shader);
        if (triangle.hasTextureCoordinateAttribute()) interpolateUV(triangle, w, areaP, shader);
    }
    
    static inline function interpolateColor(triangle : Triangle, w : Float, areaP : Vec3, shader : Shader) : Void
    {
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