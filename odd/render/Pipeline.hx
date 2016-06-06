package odd.render;

import haxe.Timer;
import odd.display.Image;
import odd.geom.Mesh;
import odd.math.Mat4;
import odd.math.Vec2;
import odd.math.Vec3;
import odd.util.color.RGB;

class Pipeline
{
    static var imageBuffer : Image;
    
    static var M_world_to_camera : Mat4;
    static var M_perspective : Mat4;
    static var M_raster : Mat4;
    
    public static function init(width : Int, height : Int, image : Image) : Void
    {
        imageBuffer = image;
        
        M_world_to_camera = Mat4.translate(0, 0, 1);
        M_perspective = Mat4.perspective(90, 4 / 3, 0.1, 100);
        //M_perspective = Mat4.orthographic( -3, 3, -4, 4, 1, 100);
        M_raster = new Mat4(
            width / 2,  0,          0,  0,
            0,         -height / 2, 0,  0,
            0,          0,          1,  0,
            width / 2,  height / 2, 0,  1
        );
    }
    
    public static function run(mesh : Mesh) : Void
    {
        var positions : Array<Vec3> = mesh.geometry.positions.copy();
        var indices : Array<Int> = mesh.geometry.indices.copy();
        var colors : Array<RGB> = mesh.geometry.colors.copy();
        
        var i : Int = 0;
        while (i < positions.length)
        {
            var p : Vec3 = positions[i];
            
            p *= mesh.transform;
            p *= M_world_to_camera;
            p *= M_perspective;
            if (p.z < -1 || p.z > 1) colors[i] = RGB.RGBh(0xff0000);
            p *= M_raster;
            
            positions[i] = p;
            
            i++;
        }
        
        i = 0;
        
        if (mesh.renderMethod == RenderMethod.QUAD)
        {
            do {
                var i1 : Int = indices[i];
                var i2 : Int = indices[i + 1];
                var i3 : Int = indices[i + 2];
                var i4 : Int = indices[i + 3];
                
                var p1 : Vec3 = positions[i1];
                var p2 : Vec3 = positions[i2];
                var p3 : Vec3 = positions[i3];
                var p4 : Vec3 = positions[i4];
                
                var c1 : RGB = colors[i1];
                var c2 : RGB = colors[i2];
                var c3 : RGB = colors[i3];
                var c4 : RGB = colors[i4];
                
                if (mesh.cullMethod == CullMethod.CLOCKWISE)
                {
                    DrawFunctions.drawTriangle(p1, p2, p3, c1, c2, c3, imageBuffer);
                    DrawFunctions.drawTriangle(p3, p4, p1, c3, c4, c1, imageBuffer);
                }
                else
                {
                    DrawFunctions.drawTriangle(p4, p3, p2, c4, c3, c2, imageBuffer);
                    DrawFunctions.drawTriangle(p2, p1, p4, c2, c1, c4, imageBuffer);
                }
                
            } while ((i += 4) < indices.length);
        }
        else
        {
            do {
                var i1 : Int = indices[(mesh.cullMethod == CullMethod.CLOCKWISE) ? i : (i + 2)];
                var i2 : Int = indices[i + 1];
                var i3 : Int = indices[(mesh.cullMethod == CullMethod.CLOCKWISE) ? (i + 2) : i];
                
                var p1 : Vec3 = positions[i1];
                var p2 : Vec3 = positions[i2];
                var p3 : Vec3 = positions[i3];
                
                var c1 : RGB = colors[i1];
                var c2 : RGB = colors[i2];
                var c3 : RGB = colors[i3];
                
                switch (mesh.renderMethod)
                {
                    case RenderMethod.LINE:
                        DrawFunctions.drawLine(p1, c1, p2, c2, imageBuffer);
                        DrawFunctions.drawLine(p2, c2, p3, c3, imageBuffer);
                        DrawFunctions.drawLine(p3, c3, p1, c1, imageBuffer);
                    case RenderMethod.TRIANGLE:
                        DrawFunctions.drawTriangle(p1, p2, p3, c1, c2, c3, imageBuffer);
                    default:
                        DrawFunctions.drawPoint(p1, c1, imageBuffer);
                        DrawFunctions.drawPoint(p2, c2, imageBuffer);
                        DrawFunctions.drawPoint(p3, c3, imageBuffer);
                }
            } while ((i += 3) < indices.length);
        }
        
        positions = null;
        indices = null;
        colors = null;
    }
}

private class DrawFunctions
{
    public static inline function drawPoint(point : Vec3, color : RGB, image : Image) : Void
    {
        image.point(Std.int(point.x), Std.int(point.y), color);
    }
    
    public static inline function drawLine(p1 : Vec3, c1 : RGB, p2 : Vec3, c2 : RGB, image : Image) : Void
    {
        var x1 : Int = Std.int(p1.x);
        var y1 : Int = Std.int(p1.y);
        var z1 : Float = 1 / p1.z;
        
        var x2 : Int = Std.int(p2.x);
        var y2 : Int = Std.int(p2.y);
        var z2 : Float = 1 / p2.z;
        
        var cp1 : RGB = RGB.RGBf(c1.rf * z1, c1.gf * z1, c1.bf * z1);
        var cp2 : RGB = RGB.RGBf(c2.rf * z2, c2.gf * z2, c2.bf * z2);
        
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
                var r : Float = (s1 * cp1.rf + s2 * cp2.rf) * z;
                var g : Float = (s1 * cp1.gf + s2 * cp2.gf) * z;
                var b : Float = (s1 * cp1.bf + s2 * cp2.bf) * z;
                
                image.pixel(x, y, z, RGB.RGBf(r, g, b));
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
    
    public static inline function drawTriangle(a : Vec3, b : Vec3, c : Vec3, ca : RGB, cb : RGB, cc : RGB, image : Image) : Void
    {
        var p0 : Vec2 = new Vec2(0, 0);
        var p1 : Vec2 = new Vec2(a.x, a.y);
        var p2 : Vec2 = new Vec2(b.x, b.y);
        var p3 : Vec2 = new Vec2(c.x, c.y);
        
        var minX : Int = Std.int(Math.min(a.x, Math.min(b.x, c.x)));
        var minY : Int = Std.int(Math.min(a.y, Math.min(b.y, c.y)));
        var maxX : Int = Std.int(Math.max(a.x, Math.max(b.x, c.x)));
        var maxY : Int = Std.int(Math.max(a.y, Math.max(b.y, c.y)));
        
        var p1z : Float = 1 / a.z;
        var p2z : Float = 1 / b.z;
        var p3z : Float = 1 / c.z;
        
        var p1c : RGB = RGB.RGBf(ca.rf * p1z, ca.gf * p1z, ca.bf * p1z);
        var p2c : RGB = RGB.RGBf(cb.rf * p2z, cb.gf * p2z, cb.bf * p2z);
        var p3c : RGB = RGB.RGBf(cc.rf * p3z, cc.gf * p3z, cc.bf * p3z);
        
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
                    
                    var r : Float = (a1 * p1c.rf + a2 * p2c.rf + a3 * p3c.rf) * z;
                    var g : Float = (a1 * p1c.gf + a2 * p2c.gf + a3 * p3c.gf) * z;
                    var b : Float = (a1 * p1c.bf + a2 * p2c.bf + a3 * p3c.bf) * z;
                    
                    image.pixel(j, i, z, RGB.RGBf(r, g, b));
                }
                
                j++;
            }
            i++;
        }
    }
    
    public static inline function edge(point1 : Vec2, point2 : Vec2, point3 : Vec2) : Float
    {
        return (point3.x - point1.x) * (point2.y - point1.y) - (point3.y - point1.y) * (point2.x - point1.x);
    }
}