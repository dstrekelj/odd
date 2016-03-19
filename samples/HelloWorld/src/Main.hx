package;

import odd.geom.OddGeometry;
import odd.geom.OddMesh;
import odd.math.OddAngle;
import odd.math.OddMat4;
import odd.OddContext;
import odd.target.OddCanvasRenderer;
import odd.target.OddSysRenderer;
import odd.util.color.OddRGB;

class Main
{
    static function main()
    {
        var width = 800;
        var height = 600;
        
        var context = new OddContext(width, height, OddRGB.RGB(0x000000));
        #if js
        var renderer = new OddCanvasRenderer(width, height);
        #elseif sys
        var renderer = new OddSysRenderer(width, height);
        #end
        
        var triangleGeometry = new OddGeometry();
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
        
        var t1 = new OddMesh(triangleGeometry);
        t1.transform *= OddMat4.scale(0.5, 0.5, 0.5);
        context.render(t1);
        
        var t2 = new OddMesh(triangleGeometry);
        t2.transform *= OddMat4.translate(1, 0, 2);
        context.render(t2);
        
        var t3 = new OddMesh(triangleGeometry);
        t3.transform *= OddMat4.translate(-0.5, 0, -0.5);
        context.render(t3);
        
        renderer.render(context.image.colorBuffer.getData());
    }
}