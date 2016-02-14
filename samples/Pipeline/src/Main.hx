package;

import odd.geom.OddGeometry;
import odd.geom.OddMesh;
import odd.math.OddVec2;
import odd.render.OddRenderMethod;
import odd.target.OddCanvasRenderer;
import odd.util.color.OddRGB;

class Main extends odd.OddContext
{
    static function main()
    {
        new Main();
    }
    
    public function new()
    {
        super(640, 480, odd.util.color.OddRGB.RGB(0x000000));
        
        var triangleGeometry = OddGeometry.fromArray([
           -10, -10, 0,
            10, -10, 0,
            0,   10, 0
        ]);
        triangleGeometry.colors = [OddRGB.RGB(0xff0000), OddRGB.RGB(0x00ff00), OddRGB.RGB(0x0000ff)];
        triangleGeometry.faces = [[1, 2, 3]];
        
        var triangleMesh1 = new OddMesh(triangleGeometry);
        triangleMesh1.method = OddRenderMethod.TRIANGLE;
        triangleMesh1.translate(0, -5, 0);
        var triangleMesh2 = new OddMesh(triangleGeometry);
        triangleMesh2.method = OddRenderMethod.TRIANGLE;
        triangleMesh2.translate(0, 5, 10);
        
        render(triangleMesh1);
        render(triangleMesh2);
        
        var renderer = new OddCanvasRenderer(this.width, this.height);
        renderer.render(this.image.colorBuffer.getData());
    }
}