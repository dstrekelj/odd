package odd.rasterizer.stages;

import odd.ColorRGB;
import odd.Framebuffer;
import odd.data.DepthBuffer;
import odd.math.Vec2;
import odd.math.Vec2i;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.rasterizer.Shader;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.ds.Vertex;
import odd.rasterizer.ds.VertexAttribute;

/**
 * Handles the scan conversion of a primitive.
 * 
 * TODO: Implement point and line primitive scan conversion.
 */
class ScanConverter
{
    public static function process(framebuffer : Framebuffer, depthBuffer : DepthBuffer, shader : Shader, primitive : Primitive) : Void
    {
        //trace(primitive);
        switch (primitive)
        {
            case Primitive.Triangle(a, b, c):
                processTriangle(framebuffer, depthBuffer, shader, a, b, c);
            case _:
        }
    }
    
    private static function processTriangle(framebuffer : Framebuffer, depthBuffer : DepthBuffer, shader : Shader, a : Vertex, b : Vertex, c : Vertex) : Void
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
        
        var hasDefinedPos : Bool = (aPos != null && bPos != null && cPos != null);
        var hasDefinedCol : Bool = (aCol != null && bCol != null && cCol != null);
        var hasDevinedUV : Bool = (aUV != null && bUV != null && cUV != null);
        
        if (!hasDefinedPos)
        {
            trace("ERROR: No positions! Aborting...");
            return;
        }
        
        var min : Vec2i = new Vec2i(
            Math.floor(Math.min(aPos.x, Math.min(bPos.x, cPos.x))),
            Math.floor(Math.min(aPos.y, Math.min(bPos.y, cPos.y)))
        );
        var max : Vec2i = new Vec2i(
            Math.floor(Math.max(aPos.x, Math.max(bPos.x, cPos.x))),
            Math.floor(Math.max(aPos.y, Math.max(bPos.y, cPos.y)))
        );
        
        var p : Vec2 = new Vec2(0, 0);
        var pA : Vec2 = new Vec2(aPos.x, aPos.y);
        var pB : Vec2 = new Vec2(bPos.x, bPos.y);
        var pC : Vec2 = new Vec2(cPos.x, cPos.y);
        
        var areaABC : Float = edge(pA.x, pA.y, pB.x, pB.y, pC.x, pC.y);
        var areaP : Vec3 = new Vec3(0, 0, 0);
        
        var fragmentCoordinate : Vec4 = new Vec4(0, 0, 0, 1);
        var pixelCoordinate : Vec2i = new Vec2i(0, 0);
        
        var i = min.y;
        while (i <= max.y)
        {
            p.y = i + 0.5;
            
            var j = min.x;
            while (j <= max.x)
            {
                p.x = j + 0.5;
                
                areaP.x = edge(pA.x, pA.y, pB.x, pB.y, p.x, p.y);
                areaP.y = edge(pB.x, pB.y, pC.x, pC.y, p.x, p.y);
                areaP.z = edge(pC.x, pC.y, pA.x, pA.y, p.x, p.y);
                
                // Note: counter-clockwise winding order has negative area
                
                if (areaP.x <= 0 && areaP.y <= 0 && areaP.z <= 0)
                {
                    // TODO: Interpolate
                    areaP /= areaABC;
                    
                    var z : Float = 1 / (areaP.y / aPos.z + areaP.z / bPos.z + areaP.x / cPos.z);
                    
                    if (hasDefinedCol)
                    {
                        interpolateColor(shader, areaP, aCol, bCol, cCol);
                    }
                    
                    if (hasDevinedUV)
                    {
                        interpolateUV(shader, areaP, aUV, bUV, cUV);
                    }
                    
                    if (z < depthBuffer.get(j, i))
                    {
                        fragmentCoordinate.x = p.x;
                        fragmentCoordinate.y = p.y;
                        fragmentCoordinate.z = z;
                        
                        pixelCoordinate.x = j;
                        pixelCoordinate.y = i;
                        
                        if (shader.fragment(fragmentCoordinate, pixelCoordinate))
                        {
                            depthBuffer.set(j, i, z);
                            var color = odd.ColorRGB.RGBf(shader.fragmentColor.x, shader.fragmentColor.y, shader.fragmentColor.z);
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
    
    private static inline function interpolateColor(shader : Shader, areaP : Vec3, aCol : Vec3, bCol : Vec3, cCol : Vec3) : Void
    {
        var r = (areaP.y * aCol.x + areaP.z * bCol.x + areaP.x * cCol.x);
        var g = (areaP.y * aCol.y + areaP.z * bCol.y + areaP.x * cCol.y);
        var b = (areaP.y * aCol.z + areaP.z * bCol.z + areaP.x * cCol.z);
        
        shader.fragmentColor.x = r;
        shader.fragmentColor.y = g;
        shader.fragmentColor.z = b;
    }
    
    private static inline function interpolateUV(shader : Shader, areaP : Vec3, aUV : Vec2, bUV : Vec2, cUV : Vec2) : Void
    {
        var u = (areaP.y * aUV.x + areaP.z * bUV.x + areaP.x * cUV.x);
        var v = (areaP.y * aUV.y + areaP.z * bUV.y + areaP.x * cUV.y);
        
        shader.fragmentTextureCoordinate.x = u;
        shader.fragmentTextureCoordinate.y = v;
    }
}