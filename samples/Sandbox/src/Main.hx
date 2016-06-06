package;

import odd.Context;
import odd.geom.Geometry;
import odd.geom.Mesh;
import odd.macro.LoaderMacros;
import odd.math.Angle;
import odd.math.Mat4;
import odd.render.CullMethod;
import odd.render.RenderMethod;
import odd.target.CanvasRenderer;
import odd.util.color.RGB;

class Main
{
	static function main()
	{
		var width = 800;
		var height = 600;
		
		var context = new Context(width, height, RGB.rgb(0x000000));
		var renderer = new CanvasRenderer(width, height);
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
		
		var teapotGeometry = LoaderMacros.fromOBJ("res/teapot.obj");
		var teapotMesh = new Mesh(teapotGeometry);
		teapotMesh.transform *= Mat4.rotateX(Angle.rad( -45));
		teapotMesh.transform *= Mat4.rotateY(Angle.rad(15));
		teapotMesh.transform *= Mat4.translate(0, -1, 6);
		teapotMesh.cullMethod = CullMethod.COUNTER_CLOCKWISE;
		context.render(teapotMesh);
		
		renderer.render(context.image.colorBuffer.getData());
	}
}