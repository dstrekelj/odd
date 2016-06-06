package odd.target;

import haxe.io.Bytes;
import haxe.io.BytesData;

class SysRenderer
{
    var width : Int;
    var height : Int;
    
    var bytes : Bytes;
    var image : StringBuf;
    
    public function new(width : Int, height : Int)
    {
        trace('-- OddSysRenderer --');
        
        this.width = width;
        this.height = height;
    }
    
    public function render(bufferData : BytesData) : Void
    {
        image = new StringBuf();
        bytes = Bytes.ofData(bufferData);
        
        for (row in 0...height)
        {
            for (column in 0...width)
            {
                var index = (column + row * width) * 4;
                image.addChar(putChar(bytes.get(index), bytes.get(index + 1), bytes.get(index  + 2)));
            }
            image.addChar(10);
        }
        
        #if sys
        Sys.print(image.toString());
        #end
    }
    
    function putChar(r : Int, g : Int, b : Int) : Int
    {
        var value = r + g + b;
        
        return switch(255 - value / 3)
        {
            case v if (v >= 250): 32;
            case v if (v >= 225): 46;
            case v if (v >= 200): 58;
            case v if (v >= 175): 45;
            case v if (v >= 150): 61;
            case v if (v >= 125): 43;
            case v if (v >= 100): 42;
            case v if (v >= 75): 35;
            case v if (v >= 50): 37;
            case v if (v >= 25): 64;
            case _: 64;
        }
    }
}