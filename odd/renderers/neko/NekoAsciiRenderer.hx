package odd.renderers.neko;
import haxe.io.Bytes;
import haxe.io.BytesData;

class NekoAsciiRenderer
{
    var width : Int;
    var height : Int;
    
    var bytes : Bytes;
    var image : StringBuf;

    public function new(width : Int, height : Int) 
    {
        this.width = width;
        this.height = height;
    }
    
    public function render(bufferData : BytesData) : Void
    {
        image = new StringBuf();
        bytes = Bytes.ofData(bufferData);
        
        for (row in 0...height)
        {
            for (col in 0...width)
            {
                putChar(bytes.get((col + row * width) * 4), bytes.get((col + row * width) * 4 + 1), bytes.get((col + row * width) * 4 + 2));
            }
            image.addChar(10);
        }
        
        #if neko
        Sys.print(image.toString());
        Sys.command('cls');
        #end
    }
    
    public function putChar(r : Int, g : Int, b : Int) : Void
    {
        var value : Int = r + g + b;
        
        if (value >= 567)
        {
            image.addChar(Character.WHITE);
        }
        else if (value >= 378)
        {
            image.addChar(Character.LIGHT_GREY);
        }
        else if (value >= 189)
        {
            image.addChar(Character.DARK_GREY);
        }
        else
        {
            image.addChar(Character.BLACK);
        }
    }
}

@:enum
abstract Character(Int) from Int to Int
{
    var BLACK = 32;
    var LIGHT_GREY = 176;
    var DARK_GREY = 177;
    var WHITE = 178;
}