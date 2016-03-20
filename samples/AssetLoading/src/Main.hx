package;

import odd.geom.OddGeometry;
import odd.geom.OddMesh;
import odd.macro.OddLoaderMacros;
import odd.math.OddAngle;
import odd.math.OddMat4;
import odd.OddContext;
import odd.render.OddCullMethod;
import odd.render.OddRenderMethod;
import odd.target.OddCanvasRenderer;
import odd.target.OddSysRenderer;
import odd.util.color.OddRGB;

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
        
        var context = new OddContext(width, height, OddRGB.RGB(0x000000));
        #if js
        var renderer = new OddCanvasRenderer(width, height);
        #elseif sys
        var renderer = new OddSysRenderer(width, height);
        #end
        
        var teapotGeometry = OddLoaderMacros.fromOBJ("res/teapot.obj");
        var teapotMesh = new OddMesh(teapotGeometry);
        teapotMesh.transform *= OddMat4.rotateX(OddAngle.rad( -45));
        teapotMesh.transform *= OddMat4.rotateY(OddAngle.rad(15));
        teapotMesh.transform *= OddMat4.translate(0, -1, 6);
        teapotMesh.cullMethod = OddCullMethod.COUNTER_CLOCKWISE;
        context.render(teapotMesh);
        
        renderer.render(context.image.colorBuffer.getData());
    }
}