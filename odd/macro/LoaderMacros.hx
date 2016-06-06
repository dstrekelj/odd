package odd.macro;

import odd.geom.Geometry;
import odd.math.Vec3;
import odd.util.color.RGB;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileSeek;

using haxe.macro.Tools;
#end

class LoaderMacros
{
    public static macro function fromOBJ(path : String) : Expr
    {
        var input : FileInput = File.read(path, false);
        var positions = new Array<Float>();
        var indices = new Array<Int>();
        
        while (!input.eof())
        {
            try
            {
                switch (String.fromCharCode(input.readByte()))
                {
                    case "v":
                        input.seek(1, FileSeek.SeekCur);
                        var v = input.readLine().split(" ");
                        positions.push(Std.parseFloat(v[0]));
                        positions.push(Std.parseFloat(v[1]));
                        positions.push(Std.parseFloat(v[2]));
                    case "f":
                        input.seek(1, FileSeek.SeekCur);
                        var f = input.readLine().split(" ");
                        var i = 0;
                        do {
                            indices.push(Std.parseInt(f[i]) - 1);
                        } while (i++ < (f.length - 1));
                    default:
                }
            }
            catch (e : Dynamic)
            {
                break;
            }
        }
        
        return macro Geometry.fromGeometryData($v{positions}, $v{indices});
    }
}