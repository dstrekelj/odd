package odd.render;

import odd.display.OddImage;
import odd.geom.OddMesh;
import odd.math.OddMat4;
import odd.math.OddVec3;
import odd.util.color.OddRGB;

class OddPipeline
{
    static var M_world_to_camera : OddMat4;
    static var M_perspective : OddMat4;
    static var M_ndc : OddMat4;
    static var M_raster : OddMat4;
    
    public static function init(width : Int, height : Int) : Void
    {
        M_world_to_camera = OddMat4.translate(0, 0, 20);
        M_perspective = OddMat4.identity();
        M_ndc = OddMat4.identity();
        M_raster = new OddMat4(
            width / 2,  0,          0,  0,
            0,         -height / 2, 0,  0,
            0,          0,          1,  0,
            width / 2,  height / 2, 0,  1
        );
    }
    
    public static function run(mesh : OddMesh, image : OddImage) : Void
    {
        switch (mesh.method)
        {
            case OddRenderMethod.LINE:
                drawLine(mesh, image);
            case OddRenderMethod.TRIANGLE:
                drawTriangle(mesh, image);
            default:
                drawPoint(mesh, image);
        }
    }
    
    static function drawPoint(mesh : OddMesh, image : OddImage) : Void
    {
        var vertices : Array<OddVec3> = mesh.geometry.positions;
        
        for (i in 0...vertices.length)
        {
            var vertex : OddVec3 = vertices[i];
            trace('--- local to world ---');
            trace(vertex);
            vertex *= M_world_to_camera;
            trace('--- world to camera ---');
            trace(vertex);
            vertex *= M_perspective;
            vertex.x /= vertex.z;
            vertex.y /= vertex.z;
            trace('--- perspective ---');
            trace(vertex);
            vertex *= M_ndc;
            trace('--- normalized device coordinates ---');
            trace(vertex);
            vertex *= M_raster;
            trace('--- raster space ---');
            trace(vertex);
            trace('--- END ---');
            image.point(Std.int(vertex.x), Std.int(vertex.y), mesh.geometry.colors[i]);
        }
    }
    
    static function drawLine(mesh : OddMesh, image : OddImage) : Void
    {
        var vertices : Array<OddVec3> = mesh.geometry.positions;
        var transformed : Array<OddVec3> = vertices.copy();
        
        var i : Int = 0;
        while (i < vertices.length)
        {
            var vertex : OddVec3 = vertices[i];
            trace('--- local to world ---');
            trace(vertex);
            vertex *= M_world_to_camera;
            trace('--- world to camera ---');
            trace(vertex);
            vertex *= M_perspective;
            vertex.x /= vertex.z;
            vertex.y /= vertex.z;
            trace('--- perspective ---');
            trace(vertex);
            vertex *= M_ndc;
            trace('--- normalized device coordinates ---');
            trace(vertex);
            vertex *= M_raster;
            trace('--- raster space ---');
            trace(vertex);
            trace('--- END ---');
            transformed[i] = vertex;
            
            if ((i + 1) % 3 == 0)
            {
                var a : OddVec3 = transformed[mesh.geometry.faces[0][i - 2] - 1];
                var b : OddVec3 = transformed[mesh.geometry.faces[0][i - 1] - 1];
                var c : OddVec3 = transformed[mesh.geometry.faces[0][i - 0] - 1];
                trace(a);
                trace(b);
                trace(c);
                
                var ca : OddRGB = mesh.geometry.colors[mesh.geometry.faces[0][i - 2] - 1];
                var cb : OddRGB = mesh.geometry.colors[mesh.geometry.faces[0][i - 1] - 1];
                var cc : OddRGB = mesh.geometry.colors[mesh.geometry.faces[0][i] - 1];
                trace(ca);
                trace(cb);
                trace(cc);
                
                ca.Rf /= a.z;
                ca.Bf /= a.z;
                ca.Gf /= a.z;
                
                cb.Rf /= b.z;
                cb.Gf /= b.z;
                cb.Bf /= b.z;
                
                cc.Rf /= c.z;
                cc.Gf /= c.z;
                cc.Bf /= c.z;
                
                a.z = 1 / a.z;
                b.z = 1 / b.z;
                c.z = 1 / c.z;
                
                //image.line(Std.int(a.x), Std.int(a.y), Std.int(b.x), Std.int(b.y), ca, cb);
                drawLineFunc(a, b, ca, cb, image);
                //image.line(Std.int(b.x), Std.int(b.y), Std.int(c.x), Std.int(c.y), cb, cc);
                drawLineFunc(b, c, cb, cc, image);
                //image.line(Std.int(c.x), Std.int(c.y), Std.int(a.x), Std.int(a.y), cc, ca);
                drawLineFunc(c, a, cc, ca, image);
            }
            
            i++;
        }
    }
    
    static function drawLineFunc(a : OddVec3, b : OddVec3, c1 : OddRGB, c2 : OddRGB, image : OddImage) : Void
    {
        var x1 : Int = Std.int(a.x);
        var y1 : Int = Std.int(a.y);
        var z1 : Float = a.z;
        var x2 : Int = Std.int(b.x);
        var y2 : Int = Std.int(b.y);
        var z2 : Float = b.z;
        
        var x : Int = x1;
        var y : Int = y1;
        
        var dx : Int = Math.round(Math.abs(x2 - x1));
        var dy : Int = Math.round(Math.abs(y2 - y1));
        
        var sx : Int = x1 < x2 ? 1 : -1;
        var sy : Int = y1 < y2 ? 1 : -1;
        
        var e : Float = (dx > dy ? dx : -dy) / 2;
        
        var l : Float = Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
        trace(z1 + ', ' + z2);
        while (x != x2 || y != y2)
        {
            if (c1 == c2)
            {
                image.setPixel(x, y, c1);
            }
            else
            {
                var l1 : Float = Math.sqrt((x1 - x) * (x1 - x) + (y1 - y) * (y1 - y));
                var l2 : Float = Math.sqrt((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y));
                var s1 : Float = l2 / l;
                var s2 : Float = l1 / l;
                var z : Float = 1 / (s1 * z1 + s2 * z2);
                var r : Float = (s1 * c1.Rf + s2 * c2.Rf) * z;
                var g : Float = (s1 * c1.Gf + s2 * c2.Gf) * z;
                var b : Float = (s1 * c1.Bf + s2 * c2.Bf) * z;
                trace(z + " - " + r + ", " + g + ", " + b);
                image.setPixel(x, y, OddRGB.RGBf(r, g, b));
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
    
    static function drawTriangle(mesh : OddMesh, image : OddImage) : Void
    {
        var vertices : Array<OddVec3> = mesh.geometry.positions;
        
        for (i in 0...vertices.length)
        {
            var vertex : OddVec3 = vertices[i];
            trace('--- local to world ---');
            trace(vertex);
            vertex *= M_world_to_camera;
            trace('--- world to camera ---');
            trace(vertex);
            vertex *= M_perspective;
            vertex.x /= vertex.z;
            vertex.y /= vertex.z;
            trace('--- perspective ---');
            trace(vertex);
            vertex *= M_ndc;
            trace('--- normalized device coordinates ---');
            trace(vertex);
            vertex *= M_raster;
            trace('--- raster space ---');
            trace(vertex);
            trace('--- END ---');
            //image.point(Std.int(vertex.x), Std.int(vertex.y), mesh.geometry.colors[i]);
        }
    }
}