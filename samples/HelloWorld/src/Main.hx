package;

import odd.geom.OddGeometry;
import odd.geom.OddMesh;
import odd.math.OddAngle;
import odd.math.OddMat4;
import odd.math.OddVec2;
import odd.math.OddVec3;
import odd.OddContext;
import odd.target.OddCanvasRenderer;
import odd.util.color.OddRGB;

class Main extends OddContext
{
    static function main()
    {
        new Main();
    }
    
    public function new()
    {
        super(640, 480, OddRGB.RGB(0x000000));
        
        //image.line(320, 240, 640, 240, OddColor.RGB(0xff0000));
        //image.line(320, 240, 0, 240, OddColor.RGB(0x00ff00));
        //image.line(320, 240, 320, 480, OddColor.RGB(0x0000ff));
        //image.line(320, 240, 320, 0, OddColor.RGB(0xffffff));
        
        //image.circle(320, 240, 50, OddColor.RGB(0xff00ff));
        
        // Testing a pipeline here
        
        var triangleGeometry = OddGeometry.fromArray([
           -10, -10, 0,
            10, -10, 0,
            0,   10, 0
        ]);
        triangleGeometry.indices = [1, 2, 3];
        
        var triangleMesh1 = new OddMesh(triangleGeometry);
        var triangleMesh2 = new OddMesh(triangleGeometry);
        
        triangleMesh1.translate(-20, 0, 0);
        triangleMesh2.translate(20, 0, 0);
        
        // Transforms local positions to world positions
        var M_local_to_world = OddMat4.identity();
        // Transforms world positions to camera positions
        var M_world_to_camera = OddMat4.translate(0, 0, 50);
        // Perspective transform, after which perspective division occurs
        var M_perspective = OddMat4.identity();
        // Normalization
        var M_ndc = OddMat4.identity();
        // Transforms normalized coordinates to raster space
        var M_raster = OddMat4.fromArray([
            320,  0,   0, 0,
            0,   -240, 0, 0,
            0,    0,   1, 0,
            320,  240, 0, 1
        ]);
        
        function transform(mesh : OddMesh) {
            for (vertex in mesh.geometry.positions) {
                vertex *= mesh.transform;
                vertex *= M_local_to_world;
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
                image.point(Std.int(vertex.x), Std.int(vertex.y), OddRGB.RGB(0xffff00));
            }
        }
        
        transform(triangleMesh1);
        transform(triangleMesh2);
        
        // End testing pipeline
        
        //var renderer = new OddCanvasRenderer(640, 480);
        //renderer.render(this.image.getData());
        
        this.render(triangleMesh1);
    }
}