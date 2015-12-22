package;

import haxe.Timer;
import odd.Context;
import odd.geom.Vertex;
import odd.math.Mat4;
import odd.math.Vec4;
import odd.Scene;

class Vertices extends Scene
{
    var p1 : Vertex;
    var p2 : Vertex;
    
    var screenSpace : Matrix4;
    var perspective : Matrix4;
    var projection : Matrix4;
    
    override public function create() : Void
    {
        super.create();
        
        p1 = new Vertex(400, 300, 10);
        p2 = new Vertex(500, 400, 10);
        
        screenSpace = Matrix4.screenSpace(context.width / 2, context.height / 2);
        
        //perspective = Matrix4.perspective(70, context.width / context.height, 0.1, 1000); 
        //var x = Math.floor((star.x / star.z) * halfWidth + halfWidth);
        //var y = Math.floor((star.y / star.z) * halfHeight + halfHeight);
        
        projection = Matrix4.projection(0, context.width, 0, context.height, 0.1, 100);
        
        perspective = new Matrix4(
            1 / (context.width / 2),    0,                          0,  0,
            0,                          1 / (context.height / 2),   0,  0,
            0,                          0,                          1,  0,
            context.width / 2,          context.height / 2,         0,  1
        );
    }
    
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
        //p2.position.z += 0.1;
    }
    
    override public function draw() : Void
    {
        super.draw();
        
        buffer.setPixel(Math.round(p1.position.x), Math.round(p1.position.y), 0xffffffff);
        
        var v1 = p2.transform(screenSpace).perspectiveDivide();
        trace(v1.position);
        buffer.setPixel(Math.round(v1.position.x), Math.round(v1.position.y), 0xffffffff);
        
        /*
        //var transformed : Vector4 = new Vector4(p2.position.x / p2.position.z, p2.position.y / p2.position.z, p2.position.z, p2.position.w);
        //transformed = perspective * transformed;
        var transformed : Vector4 = projection * p2.position;
        //transformed = perspective * transformed;
        //transformed.x = transformed.x / transformed.z;
        //transformed.y = transformed.y / transformed.z;
        trace(transformed);
        buffer.setPixel(Math.round(transformed.x), Math.round(transformed.y), 0xffffffff);
        */
    }
}