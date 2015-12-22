package;

import haxe.Timer;
import odd.geom.Vertex;
import odd.math.Vec3.Vector3;
import odd.math.Mat4.Matrix4;
import odd.math.Vec4.Vector4;
import odd.Scene;

class Vertices extends Scene
{
    var p1 : Vertex;
    var p2 : Vertex;
    var p3 : Vertex;
    
    var screenSpace : Matrix4;
    var perspective : Matrix4;
    var projection : Matrix4;
    
    var camera : Matrix4;
    var translation : Matrix4;
    var rotation : Matrix4;
    var scale : Matrix4;
    
    override public function create() : Void
    {
        super.create();
        
        p1 = new Vertex(200, 100, 1);
        p2 = new Vertex(500, 400, 3);
        p3 = new Vertex(600, 200, 5);
        
        screenSpace = Matrix4.screenSpace(context.width / 2, context.height / 2);
        
        projection = Matrix4.projection(0, context.width, 0, context.height, 0.1, 100);
        
        perspective = new Matrix4(
            1 / (context.width / 2),    0,                          0,  0,
            0,                          1 / (context.height / 2),   0,  0,
            0,                          0,                          1,  0,
            context.width / 2,          context.height / 2,         0,  1
        );
        
        camera = Matrix4.identity();
        translation = Matrix4.translate(0, 0, -0.1);
        scale = Matrix4.scale(10, 10, 10);
        
        var m = new Matrix4(
            0.718762, 0.615033,-0.324214, 0,
           -0.393732, 0.744416, 0.539277, 0,
            0.573024,-0.259959, 0.777216, 0,
            0.526967, 1.254234, -2.53215, 1
        );
        
        var p = new odd.math.Vec3.Vector3(-0.5, 0.5, -0.5);
        
        //trace(p * m);
        
        var p_world = new Vector3(200, 300, 10);
        var p_screen = p_world * camera;
        p_screen.x /= p_screen.z;
        p_screen.y /= p_screen.z;
        
        var p_ndc = new Vector3();
        p_ndc.x = (p_screen.x + context.width / 2) / context.width;
        p_ndc.y = (p_screen.y + context.height / 2) / context.height;
        
        var p_raster = new Vector3();
        p_raster.x = p_ndc.x * context.width;
        p_raster.y = p_ndc.y * context.height;
        
        trace(p_screen);
        trace(p_ndc);
        trace(p_raster);
    }
    
    var time : Float = 0;
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
        time += elapsed;
        rotation = Matrix4.rotateZ(elapsed);
        p1.position = p1.position * rotation;
        p2.position = p2.position * rotation;
        p3.position = p3.position * rotation;
    }
    
    override public function draw() : Void
    {
        super.draw();
        
        var p_screen = p1.position * camera;
        p_screen.x /= p_screen.z;
        p_screen.y /= p_screen.z;
        
        var p_ndc = new Vector3();
        p_ndc.x = (p_screen.x + context.width / 2) / context.width;
        p_ndc.y = (p_screen.y + context.height / 2) / context.height;
        
        var p_raster = new Vector3();
        p_raster.x = p_ndc.x * context.width;
        p_raster.y = p_ndc.y * context.height;
        
        buffer.setPixel(Math.round(p_raster.x), Math.round(p_raster.y), 0xffffffff);
        
        var p_screen = p2.position * camera;
        p_screen.x /= p_screen.z;
        p_screen.y /= p_screen.z;
        
        var p_ndc = new Vector3();
        p_ndc.x = (p_screen.x + context.width / 2) / context.width;
        p_ndc.y = (p_screen.y + context.height / 2) / context.height;
        
        var p_raster = new Vector3();
        p_raster.x = p_ndc.x * context.width;
        p_raster.y = p_ndc.y * context.height;
        
        buffer.setPixel(Math.round(p_raster.x), Math.round(p_raster.y), 0xffffffff);
        
        var p_screen = p3.position * camera;
        p_screen.x /= p_screen.z;
        p_screen.y /= p_screen.z;
        
        var p_ndc = new Vector3();
        p_ndc.x = (p_screen.x + context.width / 2) / context.width;
        p_ndc.y = (p_screen.y + context.height / 2) / context.height;
        
        var p_raster = new Vector3();
        p_raster.x = p_ndc.x * context.width;
        p_raster.y = p_ndc.y * context.height;
        
        buffer.setPixel(Math.round(p_raster.x), Math.round(p_raster.y), 0xffffffff);
    }
}