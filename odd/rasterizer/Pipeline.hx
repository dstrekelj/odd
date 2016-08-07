package odd.rasterizer;

import odd.Framebuffer;
import odd.geom.Geometry;
import odd.geom.Mesh;
import odd.math.Angle;
import odd.math.Vec2;
import odd.rasterizer.RenderMethod;
import odd.math.Mat4x4;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.rasterizer.ds.Primitive;
import odd.rasterizer.ds.Vertex;
import odd.rasterizer.ds.VertexAttribute;
import odd.rasterizer.stages.PrimitiveAssembler;
import odd.rasterizer.stages.ScanConverter;
import odd.rasterizer.stages.VertexPostProcessor;
import odd.rasterizer.stages.VertexProcessor;

/**
 * Rasterisation pipeline.
 */
class Pipeline
{
    public var shader : Shader;
    
    private var meshes : Array<Mesh>;
    private var transformView : Mat4x4;
    private var transformProjection : Mat4x4;
    private var transformViewport : Mat4x4;
    
    public function new(viewportWidth : Int, viewportHeight : Int)
    {
        shader = new Shader();
        
        meshes = new Array<Mesh>();
        transformView = Mat4x4.translate(0, 0, -4);
        transformProjection = Mat4x4.perspective(100, 4 / 3, 0.1, 10);
        // Negative Y.y component to mirror image vertically
        transformViewport = new Mat4x4(
            viewportWidth / 2,   0,                     0,  0,
            0,                  -viewportHeight / 2,    0,  0,
            0,                   0,                     1,  0,
            viewportWidth / 2,   viewportHeight / 2,    0,  1
        );
    }
    
    public function addMesh(mesh : Mesh) : Void
    {
        meshes.push(mesh);
    }
    
   /* private inline function getVec2(array, startIndex) : Vec2
    {
        return new Vec2(array[startIndex], array[startIndex + 1]);
    }
    
    private inline function getVec3(array, startIndex) : Vec3
    {
        return new Vec3(array[startIndex], array[startIndex + 1], array[startIndex + 2]);
    }*/
    
    public function execute(framebuffer : Framebuffer) : Void
    {
        for (mesh in meshes)
        {
            shader.transformModel = mesh.transform;
            shader.transformView = transformView;
            
            var indices = mesh.geometry.indices;
            
            var i = 0;
            while (i < indices.length)
            {
                var primitiveIndices = [indices[i], indices[i + 1], indices[i + 2]];
                
                // Primitive assembly
                var primitive = PrimitiveAssembler.assembleTriangle(primitiveIndices, mesh.geometry);
                trace("1. PRIMITIVE ASSEMBLY...", primitive);
                
                switch (primitive)
                {
                    case Primitive.Triangle(a, b, c):
                        // Vertex processing
                        trace("2. VERTEX PROCESSING...");
                        a = VertexProcessor.process(a, shader);
                        b = VertexProcessor.process(b, shader);
                        c = VertexProcessor.process(c, shader);
                        primitive = Primitive.Triangle(a, b, c);
                        trace(primitive);
                        // Vertex post-processing
                        trace("3. VERTEX POST-PROCESSING...");
                        a = VertexPostProcessor.process(a, transformProjection, transformViewport);
                        b = VertexPostProcessor.process(b, transformProjection, transformViewport);
                        c = VertexPostProcessor.process(c, transformProjection, transformViewport);
                        primitive = Primitive.Triangle(a, b, c);
                        trace(primitive);
                        // Scan conversion
                        trace("4. SCAN CONVERSION...");
                        ScanConverter.process(framebuffer, shader, primitive);
                    case _:
                        return;
                }
                
                /*var c1 = getVec3(mesh.geometry.colors, i);
                var n1 = getVec3(mesh.geometry.normals, i);
                var p1 = getVec3(mesh.geometry.positions, i);
                var t1 = getVec2(mesh.geometry.uvs, i);
                
                var c2 = getVec3(mesh.geometry.colors, i + 1);
                var n2 = getVec3(mesh.geometry.normals, i + 1);
                var p2 = getVec3(mesh.geometry.positions, i + 1);
                var t2 = getVec2(mesh.geometry.uvs, i + 1);
                
                var c3 = getVec3(mesh.geometry.colors, i + 2);
                var n3 = getVec3(mesh.geometry.normals, i + 2);
                var p3 = getVec3(mesh.geometry.positions, i + 2);
                var t3 = getVec2(mesh.geometry.uvs, i + 2);
                
                switch (mesh.renderMethod)
                {
                    switch RenderMethod.Point:
                        renderPoint(c1, p1, c2, p2, c3, p3);
                    switch RenderMethod.Wire:
                        renderWire(c1, p1, c2, p2, c3, p3);
                    switch RenderMethod.Fill:
                        renderFill(c1, n1, p1, t1, c2, n2, p2, t2, c3, n3, p3, t3);
                }*/
                
                i += 3;
            }
            
            /*var i = 0;
            while (i < vertices.length)
            {
                var p = new Vec3(
                    vertices[i],
                    vertices[i + 1],
                    vertices[i + 2]
                );
                
                switch (mesh.renderMethod)
                {
                    case RenderMethod.Point:
                        renderPoint(framebuffer, p);
                    case RenderMethod.Wire:
                        points.push(p);
                        if (points.length == 2)
                        {
                            renderLine(framebuffer, points[0], points[1]);
                            points.splice(0, points.length);
                        }
                    case RenderMethod.Fill:
                        points.push(p);
                        if (points.length == 3)
                        {
                            renderTriangle(framebuffer, points[0], points[1], points[2]);
                            points.splice(0, points.length);
                        }
                }
                
                i += 3;
            }*/
        }
    }
    
    /*private function renderPoint(framebuffer : Framebuffer, a : Vec3) : Void
    {
        trace("1", a);
        var coord = shader.vertex(a);
        trace("2", coord);
        coord *= transformProjection;
        trace("3", coord);
        // Discard points outside of the view volume
        coord = clip(coord);
        if (coord == null) return;
        
        coord = coord * transformViewport;
        trace("4", coord);
        var p = new Vec3(
            coord.x / coord.w,
            coord.y / coord.w,
            coord.z / coord.w
        );
        trace("5", p);
        DrawFunctions.drawPoint(framebuffer, p.x, p.y, 0xffffff);
    }
    
    private function renderLine(framebuffer : Framebuffer, a : Vec3, b : Vec3) : Void
    {
        var coordA = shader.vertex(a);
        coordA = clip(coordA);
        if (coordA == null) return;
        
        coordA = coordA * transformViewport;
        var pA = new Vec3(
            coordA.x / coordA.w,
            coordA.y / coordA.w,
            coordA.z / coordA.w
        );
        
        var coordB = shader.vertex(b);
        coordB = clip(coordB);
        if (coordB == null) return;
        
        coordB = coordB * transformViewport;
        var pB = new Vec3(
            coordB.x / coordB.w,
            coordB.y / coordB.w,
            coordB.z / coordB.w
        );
        
        DrawFunctions.drawLine(framebuffer, pA, 0xffffff, pB, 0xffffff);
    }
    
    private function renderTriangle(framebuffer : Framebuffer, a : Vec3, b : Vec3, c : Vec3) : Void
    {
        
    }
    
    private function clip(a : Vec4) : Vec4
    {
        if (a.x < -a.w || a.x > a.w) return null;
        if (a.y < -a.w || a.y > a.w) return null;
        if (a.z < -a.w || a.z > a.w) return null;
        return a;
    }*/
}

private class DrawFunctions
{
    public static function drawPoint(framebuffer : Framebuffer, x : Float, y : Float, color : Int) : Void
    {
        framebuffer.setPixel(Std.int(x), Std.int(y), color);
    }
    
    public static function drawLine(framebuffer : Framebuffer, p1 : Vec3, c1 : Int, p2 : Vec3, c2 : Int) : Void
    {
        var x1 : Int = Std.int(p1.x);
        var y1 : Int = Std.int(p1.y);
        var z1 : Float = 1 / p1.z;
        
        var x2 : Int = Std.int(p2.x);
        var y2 : Int = Std.int(p2.y);
        var z2 : Float = 1 / p2.z;
        
        //var cp1 : OddRGB = OddRGB.RGBf(c1.Rf * z1, c1.Gf * z1, c1.Bf * z1);
        var cp1 = c1;
        //var cp2 : OddRGB = OddRGB.RGBf(c2.Rf * z2, c2.Gf * z2, c2.Bf * z2);
        var cp2 = c2;
        
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
                //image.pixel(x, y, z, cp1);
                framebuffer.setPixel(x, y, cp1);
            }
            else
            {
                //var r : Float = (s1 * cp1.Rf + s2 * cp2.Rf) * z;
                //var g : Float = (s1 * cp1.Gf + s2 * cp2.Gf) * z;
                //var b : Float = (s1 * cp1.Bf + s2 * cp2.Bf) * z;
                
                //image.pixel(x, y, z, OddRGB.RGBf(r, g, b));
                framebuffer.setPixel(x, y, cp1);
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
}