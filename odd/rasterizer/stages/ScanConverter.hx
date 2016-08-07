package odd.rasterizer.stages;

import odd.ColorRGB;
import odd.Framebuffer;
import odd.math.Vec2;
import odd.math.Vec2i;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.rasterizer.Shader;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.ds.Vertex;
import odd.rasterizer.ds.VertexAttribute;

/**
 * ...
 * @author 
 */
class ScanConverter
{
    public static function process(framebuffer : Framebuffer, shader : Shader, primitive : Primitive) : Void
    {
        trace(primitive);
        switch (primitive)
        {
            case Primitive.Triangle(a, b, c):
                processTriangle(framebuffer, shader, a, b, c);
            case _:
        }
    }
    
    private static function processTriangle(framebuffer : Framebuffer, shader : Shader, a : Vertex, b : Vertex, c : Vertex) : Void
    {
        var aPos : Vec3 = null; var aCol : Vec3 = null; var aUV : Vec2 = null;
        for (attribute in a)
        {
            switch (attribute)
            {
                case VertexAttribute.Color(r, g, b):            aCol = new Vec3(r, g, b);
                case VertexAttribute.Position(x, y, z, w):      aPos = new Vec3(x, y, z);
                case VertexAttribute.TextureCoordinate(u, v):   aUV = new Vec2(u, v);
                case _:
            }
        }
        
        var bPos : Vec3 = null; var bCol : Vec3 = null;  var bUV : Vec2 = null;
        for (attribute in b)
        {
            switch (attribute)
            {
                case VertexAttribute.Color(r, g, b):            bCol = new Vec3(r, g, b);
                case VertexAttribute.Position(x, y, z, w):      bPos = new Vec3(x, y, z);
                case VertexAttribute.TextureCoordinate(u, v):   bUV = new Vec2(u, v);
                case _:
            }
        }
        
        var cPos : Vec3 = null; var cCol : Vec3 = null;  var cUV : Vec2 = null;
        for (attribute in c)
        {
            switch (attribute)
            {
                case VertexAttribute.Color(r, g, b):            cCol = new Vec3(r, g, b);
                case VertexAttribute.Position(x, y, z, w):      cPos = new Vec3(x, y, z);
                case VertexAttribute.TextureCoordinate(u, v):   cUV = new Vec2(u, v);
                case _:
            }
        }
        
        if (aPos == null || bPos == null || cPos == null)
        {
            trace("ERROR: No positions! Aborting...");
            return;
        }
        
        var min = new Vec2i(
            Math.floor(Math.min(aPos.x, Math.min(bPos.x, cPos.x))),
            Math.floor(Math.min(aPos.y, Math.min(bPos.y, cPos.y)))
        );
        var max = new Vec2i(
            Math.floor(Math.max(aPos.x, Math.max(bPos.x, cPos.x))),
            Math.floor(Math.max(aPos.y, Math.max(bPos.y, cPos.y)))
        );
        
        var p = new Vec2(0, 0);
        var pA = new Vec2(aPos.x, aPos.y);
        var pB = new Vec2(bPos.x, bPos.y);
        var pC = new Vec2(cPos.x, cPos.y);
        
        var areaABC = edge(pA.x, pA.y, pB.x, pB.y, pC.x, pC.y);
        
        var i = min.y;
        while (i <= max.y)
        {
            var j = min.x;
            while (j <= max.x)
            {
                p.x = j + 0.5;
                p.y = i + 0.5;
                
                var areaP = new Vec3(
                    edge(pA.x, pA.y, pB.x, pB.y, p.x, p.y),
                    edge(pB.x, pB.y, pC.x, pC.y, p.x, p.y),
                    edge(pC.x, pC.y, pA.x, pA.y, p.x, p.y)
                );
                
                // Counter-clockwise winding order has negative area
                if (areaP.x >= 0 && areaP.y >= 0 && areaP.z >= 0)
                {
                    // TODO: Interpolate
                    areaP /= areaABC;
                    
                    var z = 1 / (areaP.x / aPos.z + areaP.y / bPos.z + areaP.z / cPos.z);
                    
                    if (aCol != null && bCol != null && cCol != null)
                    {
                        var r = (areaP.y * aCol.x + areaP.z * bCol.x + areaP.x * cCol.x) * z;
                        var g = (areaP.y * aCol.y + areaP.z * bCol.y + areaP.x * cCol.y) * z;
                        var b = (areaP.y * aCol.z + areaP.z * bCol.z + areaP.x * cCol.z) * z;
                        shader.fragmentColor = new Vec3(r, g, b);
                    }
                    
                    if (aUV != null && bUV != null && cUV != null)
                    {
                        var u = (areaP.y * aUV.x + areaP.z * bUV.x + areaP.x * cUV.x) * z;
                        var v = (areaP.y * aUV.y + areaP.z * bUV.y + areaP.x * cUV.y) * z;
                        shader.fragmentTextureCoordinate = new Vec2(u, v);
                    }
                    
                    if (shader.fragment(new Vec4(p.x, p.y, 1, 1), true, new Vec2i(j, i)))
                    {
                        var color = odd.ColorRGB.RGBf(shader.fragmentColor.x, shader.fragmentColor.y, shader.fragmentColor.z);
                        framebuffer.setPixel(j, i, color);
                    }
                }
                else if (areaP.x <= 0 && areaP.y <= 0 && areaP.z <= 0)
                {
                    // TODO: Interpolate
                    areaP /= areaABC;
                    
                    var z = 1 / (areaP.x / aPos.z + areaP.y / bPos.z + areaP.z / cPos.z);
                    
                    if (aCol != null && bCol != null && cCol != null)
                    {
                        var r = (areaP.y * aCol.x + areaP.z * bCol.x + areaP.x * cCol.x) * z;
                        var g = (areaP.y * aCol.y + areaP.z * bCol.y + areaP.x * cCol.y) * z;
                        var b = (areaP.y * aCol.z + areaP.z * bCol.z + areaP.x * cCol.z) * z;
                        shader.fragmentColor = new Vec3(r, g, b);
                    }
                    
                    if (aUV != null && bUV != null && cUV != null)
                    {
                        var u = (areaP.y * aUV.x + areaP.z * bUV.x + areaP.x * cUV.x) * z;
                        var v = (areaP.y * aUV.y + areaP.z * bUV.y + areaP.x * cUV.y) * z;
                        shader.fragmentTextureCoordinate = new Vec2(u, v);
                    }
                    
                    if (shader.fragment(new Vec4(p.x, p.y, 1, 1), false, new Vec2i(j, i)))
                    {
                        var color = odd.ColorRGB.RGBf(shader.fragmentColor.x, shader.fragmentColor.y, shader.fragmentColor.z);
                        framebuffer.setPixel(j, i, color);
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
}