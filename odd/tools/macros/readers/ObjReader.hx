package odd.tools.macros.readers;

import sys.io.File;
import sys.io.FileInput;

class ObjReader
{
    public static function read(path : String)
    {
        var input : FileInput = File.read(path, false);
        var positions : Array<Float> = [];
        var indices : Array<Int> = [];
        
        while (!input.eof())
        {
            try
            {
                var line = input.readLine();
                switch (line.charAt(0))
                {
                    case "v":
                        var v : Array<String> = line.split(" ");
                        positions.push(Std.parseFloat(v[1]));
                        positions.push(Std.parseFloat(v[2]));
                        positions.push(Std.parseFloat(v[3]));
                    case "f":
                        var f : Array<String> = line.split(" ");
                        indices.push(Std.parseInt(f[1]) - 1);
                        indices.push(Std.parseInt(f[2]) - 1);
                        indices.push(Std.parseInt(f[3]) - 1);
                    case _:
                        continue;
                }
            }
            catch (e : Dynamic)
            {
                break;
            }
        }

        input.close();
        
        return {
            positions: positions,
            indices: indices
        };
    }
}

typedef ObjData = {
    positions : Array<Float>,
    indices : Array<Int>
}