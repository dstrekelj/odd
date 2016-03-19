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
        var width = 360;
        var height = 120;
        
        var context = new OddContext(width, height, OddRGB.RGB(0x000000));
        #if js
        var renderer = new OddCanvasRenderer(width, height);
        #elseif sys
        var renderer = new OddSysRenderer(width, height);
        #end
        
        var cubeGeometry = OddLoaderMacros.fromOBJ("res/box.obj");
        var cubeMesh = new OddMesh(cubeGeometry);
        cubeMesh.cullMethod = OddCullMethod.COUNTER_CLOCKWISE;
        cubeMesh.renderMethod = OddRenderMethod.QUAD;
        cubeMesh.transform *= OddMat4.rotateZ(OddAngle.rad(45));
        cubeMesh.transform *= OddMat4.rotateX(OddAngle.rad(65));
        cubeMesh.transform *= OddMat4.translate(0, 0, 0.6);

        context.render(cubeMesh);
        
        renderer.render(context.image.colorBuffer.getData());
    }
}