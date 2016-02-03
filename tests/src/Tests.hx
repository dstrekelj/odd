package;

import haxe.unit.TestRunner;
import math.OddMat4Test;
import math.OddVec2Test;
import math.OddVec3Test;

class Tests extends TestRunner
{
    static function main()
    {
        new Tests();
    }
    
    public function new() 
    {
        super();
        add(new OddVec2Test());
        add(new OddVec3Test());
        add(new OddVec3Test());
        add(new OddMat4Test());
        run();
    }
}