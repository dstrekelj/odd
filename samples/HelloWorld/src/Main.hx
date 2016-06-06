package;

import odd.geom.Geometry;
import odd.geom.Mesh;
import odd.math.Angle;
import odd.math.Mat4;
import odd.Context;
import odd.target.CanvasRenderer;
import odd.target.SysRenderer;
import odd.util.color.RGB;

class Main
{
    static function main()
    {
        #if js
        var width = 800;
        var height = 600;
        #elseif sys
        var width = 360;
        var height = 120;
        #end
        
        var context = new Context(width, height, RGB.RGBh(0x000000));
        #if js
        var renderer = new CanvasRenderer(width, height);
        #elseif sys
        var renderer = new SysRenderer(width, height);
        #end
        
        var triangleGeometry = new Geometry();
        triangleGeometry.positionsFromArray([
             0,  1, 0,
            -1, -1, 0,
             1, -1, 0
        ]);
        triangleGeometry.colorsFromArrayFloat([
            1.0, 0.0, 0.0,
            0.0, 1.0, 0.0,
            0.0, 0.0, 1.0
        ]);
        triangleGeometry.indices = [0, 1, 2];
        
        var t1 = new Mesh(triangleGeometry);
        t1.transform *= Mat4.scale(0.5, 0.5, 0.5);
        context.render(t1);
        
        var t2 = new Mesh(triangleGeometry);
        t2.transform *= Mat4.translate(1, 0, 2);
        context.render(t2);
        
        var t3 = new Mesh(triangleGeometry);
        t3.transform *= Mat4.translate(-0.5, 0, -0.5);
        context.render(t3);
        
        renderer.render(context.image.colorBuffer.getData());
    }
}