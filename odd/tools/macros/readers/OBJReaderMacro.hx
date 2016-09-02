package odd.tools.macros.readers;

#if macro
import haxe.macro.Expr;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileSeek;
#end

class OBJReaderMacro
{
    public static macro function read(geometry : String, path : String) : Expr
    {
        var input : FileInput = File.read(path, false);
        var positions : Array<Float> = [];
        var indices : Array<Int> = [];
        
        while (!input.eof())
        {
            try
            {
                switch (String.fromCharCode(input.readByte()))
                {
                    case "v":
                        input.seek(1, FileSeek.SeekCur);
                        var v : Array<String> = input.readLine().split(" ");
                        positions.push(Std.parseFloat(v[0]));
                        positions.push(Std.parseFloat(v[1]));
                        positions.push(Std.parseFloat(v[2]));
                    case "f":
                        input.seek(1, FileSeek.SeekCur);
                        var f : Array<String> = input.readLine().split(" ");
                        var i = 0;
                        do
                        {
                            indices.push(Std.parseInt(f[i]) - 1);
                        }
                        while (i++ < (f.length - 1));
                    default:
                }
            }
            catch (e : Dynamic)
            {
                break;
            }
        }
        
        var e = macro {
            $i{geometry}.positions = $v{positions};
            $i{geometry}.indices = $v{indices}
        };
        
        return e;
    }
}