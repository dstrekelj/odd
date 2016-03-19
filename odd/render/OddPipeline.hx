package odd.render;

import haxe.Timer;
import odd.display.OddImage;
import odd.geom.OddMesh;
import odd.math.OddMat4;
import odd.math.OddVec2;
import odd.math.OddVec3;
import odd.util.color.OddRGB;

class OddPipeline
{
    static var imageBuffer : OddImage;
    
    static var M_world_to_camera : OddMat4;
    static var M_perspective : OddMat4;
    static var M_ndc : OddMat4;
    static var M_raster : OddMat4;
    
    public static function init(width : Int, height : Int, image : OddImage) : Void
    {
        imageBuffer = image;
        
        M_world_to_camera = OddMat4.translate(0, 0, 1);
        M_perspective = OddMat4.identity();
        M_ndc = OddMat4.identity();
        M_raster = new OddMat4(
            width / 2,  0,          0,  0,
            0,         -height / 2, 0,  0,
            0,          0,          1,  0,
            width / 2,  height / 2, 0,  1
        );
    }
    
    public static function run(mesh : OddMesh) : Void
    {
        var positions : Array<OddVec3> = mesh.geometry.positions.copy();
        var indices : Array<Int> = mesh.geometry.indices.copy();
        var colors : Array<OddRGB> = mesh.geometry.colors.copy();
        
        var i : Int = 0;
        while (i < positions.length)
        {
            var p : OddVec3 = positions[i];
            
            p *= mesh.transform;
            p *= M_world_to_camera;
            p *= M_perspective;
            p.x /= p.z;
            p.y /= p.z;
            p *= M_ndc;
            p *= M_raster;
            
            positions[i] = p;
            
            i++;
        }
        
        i = 0;
        do {
            var i1 : Int = indices[(mesh.cullMethod == OddCullMethod.CLOCKWISE) ? i : (i + 2)];
            var i2 : Int = indices[i + 1];
            var i3 : Int = indices[(mesh.cullMethod == OddCullMethod.CLOCKWISE) ? (i + 2) : i];
            
            var p1 : OddVec3 = positions[i1];
            var p2 : OddVec3 = positions[i2];
            var p3 : OddVec3 = positions[i3];
            
            var c1 : OddRGB = colors[i1];
            var c2 : OddRGB = colors[i2];
            var c3 : OddRGB = colors[i3];
            
            switch (mesh.renderMethod)
            {
                case OddRenderMethod.LINE:
                    DrawFunctions.drawLine(p1, c1, p2, c2, imageBuffer);
                    DrawFunctions.drawLine(p2, c2, p3, c3, imageBuffer);
                    DrawFunctions.drawLine(p3, c3, p1, c1, imageBuffer);
                case OddRenderMethod.TRIANGLE:
                    DrawFunctions.drawTriangle(p1, p2, p3, c1, c2, c3, imageBuffer);
                default:
                    DrawFunctions.drawPoint(p1, c1, imageBuffer);
                    DrawFunctions.drawPoint(p2, c2, imageBuffer);
                    DrawFunctions.drawPoint(p3, c3, imageBuffer);
            }
        } while ((i += 3) < indices.length);
        
        positions = null;
        indices = null;
        colors = null;
    }
}

private class DrawFunctions
{
    public static inline function drawPoint(point : OddVec3, color : OddRGB, image : OddImage) : Void
    {
        image.point(Std.int(point.x), Std.int(point.y), color);
    }
    
    public static inline function drawLine(p1 : OddVec3, c1 : OddRGB, p2 : OddVec3, c2 : OddRGB, image : OddImage) : Void
    {
        var x1 : Int = Std.int(p1.x);
        var y1 : Int = Std.int(p1.y);
        var z1 : Float = 1 / p1.z;
        
        var x2 : Int = Std.int(p2.x);
        var y2 : Int = Std.int(p2.y);
        var z2 : Float = 1 / p2.z;
        
        var cp1 : OddRGB = OddRGB.RGBf(c1.Rf * z1, c1.Gf * z1, c1.Bf * z1);
        var cp2 : OddRGB = OddRGB.RGBf(c2.Rf * z2, c2.Gf * z2, c2.Bf * z2);
        
        var x : Int = x1;
        var y : Int = y1;
        
        var dx : Int = Math.round(Math.abs(x2 - x1));
        var dy : Int = Math.round(Math.abs(y2 - y1));
        
        var sx : Int = x1 < x2 ? 1 : -1;
        var sy : Int = y1 < y2 ? 1 : -1;
        
        var e : Float = (dx > dy ? dx : -dy) / 2;
        
        var l : Float = Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
        
        while (x != x2 || y != y2)
        {
            var l1 : Float = Math.sqrt((x1 - x) * (x1 - x) + (y1 - y) * (y1 - y));
            var l2 : Float = Math.sqrt((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y));
            
            var s1 : Float = l2 / l;
            var s2 : Float = l1 / l;
            var z : Float = 1 / (s1 * z1 + s2 * z2);
            
            if (cp1 == cp2)
            {
                image.pixel(x, y, z, cp1);
            }
            else
            {
                var r : Float = (s1 * cp1.Rf + s2 * cp2.Rf) * z;
                var g : Float = (s1 * cp1.Gf + s2 * cp2.Gf) * z;
                var b : Float = (s1 * cp1.Bf + s2 * cp2.Bf) * z;
                
                image.pixel(x, y, z, OddRGB.RGBf(r, g, b));
            }
            
            var te : Float = e;
            
            if (te > -dx)
            {
                e -= dy;
                x += sx;
            }
            
            if (te < dy)
            {
                e += dx;
                y += sy;
            }
        }
    }
    
    public static inline function drawTriangle(a : OddVec3, b : OddVec3, c : OddVec3, ca : OddRGB, cb : OddRGB, cc : OddRGB, image : OddImage) : Void
    {
        var p0 : OddVec2 = new OddVec2(0, 0);
        var p1 : OddVec2 = new OddVec2(a.x, a.y);
        var p2 : OddVec2 = new OddVec2(b.x, b.y);
        var p3 : OddVec2 = new OddVec2(c.x, c.y);
        
        var minX : Int = Std.int(Math.min(a.x, Math.min(b.x, c.x)));
        var minY : Int = Std.int(Math.min(a.y, Math.min(b.y, c.y)));
        var maxX : Int = Std.int(Math.max(a.x, Math.max(b.x, c.x)));
        var maxY : Int = Std.int(Math.max(a.y, Math.max(b.y, c.y)));
        
        var p1z : Float = 1 / a.z;
        var p2z : Float = 1 / b.z;
        var p3z : Float = 1 / c.z;
        
        var p1c : OddRGB = OddRGB.RGBf(ca.Rf * p1z, ca.Gf * p1z, ca.Bf * p1z);
        var p2c : OddRGB = OddRGB.RGBf(cb.Rf * p2z, cb.Gf * p2z, cb.Bf * p2z);
        var p3c : OddRGB = OddRGB.RGBf(cc.Rf * p3z, cc.Gf * p3z, cc.Bf * p3z);
        
        var a : Float = edge(p1, p2, p3);
        
        var i = minY;
        while (i <= maxY)
        {
            var j = minX;
            while (j <= maxX)
            {
                p0.x = j + 0.5;
                p0.y = i + 0.5;
                
                var a3 : Float = edge(p1, p2, p0);
                var a1 : Float = edge(p2, p3, p0);
                var a2 : Float = edge(p3, p1, p0);
                
                if (a1 >= 0 && a2 >= 0 && a3 >= 0)
                {
                    a1 /= a;
                    a2 /= a;
                    a3 /= a;
                    
                    var z : Float = 1 / (a1 * p1z + a2 * p2z + a3 * p3z);
                    
                    var r : Float = (a1 * p1c.Rf + a2 * p2c.Rf + a3 * p3c.Rf) * z;
                    var g : Float = (a1 * p1c.Gf + a2 * p2c.Gf + a3 * p3c.Gf) * z;
                    var b : Float = (a1 * p1c.Bf + a2 * p2c.Bf + a3 * p3c.Bf) * z;
                    
                    image.pixel(j, i, z, OddRGB.RGBf(r, g, b));
                }
                
                j++;
            }
            i++;
        }
    }
    
    public static inline function edge(point1 : OddVec2, point2 : OddVec2, point3 : OddVec2) : Float
    {
        return (point3.x - point1.x) * (point2.y - point1.y) - (point3.y - point1.y) * (point2.x - point1.x);
    }
}