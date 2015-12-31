package odd.geom;

import odd.ImageBuffer;
import odd.math.Vector3;

class Vertex
{
    public var position : Vector3;
    public var color : Int;

    public function new(x : Float, y : Float, z : Float) 
    {
        position = new Vector3(x, y, z);
    }
}