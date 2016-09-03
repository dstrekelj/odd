package odd.rasterizer.object;

import odd.math.Vec3;

/**
 * Geometry.
 */
class Geometry
{
    public var colors : Array<Float>;
    public var normals : Array<Float>;
    public var textureCoordinates : Array<Float>;
    public var positions : Array<Float>;
    
    public var indices : Array<Int>;
    
    public function new()
    {
        colors = new Array<Float>();
        positions = new Array<Float>();
        textureCoordinates = new Array<Float>();
        normals = new Array<Float>();
        
        indices = new Array<Int>();
    }
    
    public function clone() : Geometry
    {
        var g = new Geometry();
        
        g.colors = this.colors.copy();
        g.normals = this.normals.copy();
        g.positions = this.positions.copy();
        g.textureCoordinates = this.textureCoordinates.copy();
        
        g.indices = this.indices.copy();
        
        return g;
    }
}