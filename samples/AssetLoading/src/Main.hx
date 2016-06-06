package;

import odd.geom.Geometry;
import odd.geom.Mesh;
import odd.macro.LoaderMacros;
import odd.math.Angle;
import odd.math.Mat4;
import odd.Context;
import odd.render.CullMethod;
import odd.render.RenderMethod;
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
        
        var teapotGeometry = LoaderMacros.fromOBJ("res/teapot.obj");
        var teapotMesh = new Mesh(teapotGeometry);
        teapotMesh.transform *= Mat4.rotateX(Angle.rad(45));
        teapotMesh.transform *= Mat4.rotateY(Angle.rad(20));
        teapotMesh.transform *= Mat4.translate(0, -1, -6);
        teapotMesh.cullMethod = CullMethod.CLOCKWISE;
        context.render(teapotMesh);
        
        renderer.render(context.image.colorBuffer.getData());
    }
}