package;

import odd.OddContext;
import odd.geom.OddGeometry;
import odd.geom.OddMesh;
import odd.macro.OddLoaderMacros;
import odd.math.OddAngle;
import odd.math.OddMat4;
import odd.render.OddCullMethod;
import odd.render.OddRenderMethod;
import odd.target.OddCanvasRenderer;
import odd.util.color.OddRGB;

class Main
{
	static function main()
	{
		var width = 800;
		var height = 600;
		
		var context = new OddContext(width, height, OddRGB.RGB(0x000000));
		var renderer = new OddCanvasRenderer(width, height);
		/*
		var triangleGeometry = new OddGeometry();
		triangleGeometry.positionsFromArray([
			 0,  1, 0,
			-1, -1, 0,
			 1, -1, 0,
		]);
		triangleGeometry.colorsFromArrayFloat([
			1.0, 0.0, 0.0,
			0.0, 1.0, 0.0,
			0.0, 0.0, 1.0
		]);
		triangleGeometry.indices = [0, 1, 2];
		
		var tri1 = new OddMesh(triangleGeometry);
		tri1.transform *= OddMat4.translate(-1, 1, 3);
		context.render(tri1);
		
		var tri2 = new OddMesh(triangleGeometry);
		tri2.transform *= OddMat4.translate(0, 1, 2);
		context.render(tri2);
		
		var tri3 = new OddMesh(triangleGeometry);
		tri3.transform *= OddMat4.translate(1, 1, 3);
		context.render(tri3);
		
		var tri4 = new OddMesh(triangleGeometry);
		tri4.transform *= OddMat4.translate(-1, -1, 3);
		context.render(tri4);
		
		var tri5 = new OddMesh(triangleGeometry);
		tri5.transform *= OddMat4.translate(0, -1, 2);
		context.render(tri5);
		
		var tri6 = new OddMesh(triangleGeometry);
		tri6.transform *= OddMat4.translate(1, -1, 3);
		context.render(tri6);
		
		var cubeGeometry = OddLoaderMacros.fromOBJ("res/box.obj");
		var cubeMesh = new OddMesh(cubeGeometry);
		cubeMesh.renderMethod = OddRenderMethod.QUAD;
		cubeMesh.cullMethod = OddCullMethod.COUNTER_CLOCKWISE;
		cubeMesh.transform *= OddMat4.translate( 1, 0, 1);
		cubeMesh.transform *= OddMat4.rotateY(OddAngle.rad(45));
		cubeMesh.transform *= OddMat4.scale(0.4, 0.4, 0.4);
		context.render(cubeMesh);*/
		
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