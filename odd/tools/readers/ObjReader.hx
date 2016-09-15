package odd.tools.readers;

import sys.io.File;
import sys.io.FileInput;

class ObjReader
{
    public static function readPositions(path:String) : ObjData
    {
        var input : FileInput = File.read(path, false);

        var indices : Array<Int> = [];
        var positions : Array<Float> = [];

        while (!input.eof())
        {
            try
            {
                var line = input.readLine();
                var separator = line.indexOf(" ");
                var head = line.substring(0, separator);
                var tail = line.substr(separator + 1);
                switch (head)
                {
                    case "v":
                        var v : Array<String> = tail.split(" ");
                        readAttributes(positions, v);
                    case "f":
                        var f : Array<String> = tail.split(" ");
                        if (tail.indexOf("/") < 0)
                        {
                            for (fi in f)
                            {
                                if (fi != "")
                                {
                                    indices.push(Std.parseInt(fi) - 1);
                                }
                            }
                        }
                        else
                        {
                            for (fi in f)
                            {
                                if (fi != "")
                                {
                                    var values = fi.split("/");

                                    indices.push(Std.parseInt(values[0]) - 1);
                                }
                            }
                        }
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
            indices: indices,
            textureCoordinates: null,
            normals: null
        };
    }

    public static function readAll(path : String) : ObjData
    {
        var input : FileInput = File.read(path, false);
        
        var indices : Array<Int> = [];
        
        var vData : Array<Float> = [];
        var vnData : Array<Float> = [];
        var vtData : Array<Float> = [];

        var positions : Array<Float> = [];
        var normals : Array<Float> = [];
        var textureCoordinates : Array<Float> = [];
        
        while (!input.eof())
        {
            try
            {
                var line = input.readLine();
                var separator = line.indexOf(" ");
                var head = line.substring(0, separator);
                var tail = line.substr(separator + 1);
                switch (head)
                {
                    case "v":
                        var v : Array<String> = tail.split(" ");
                        readAttributes(vData, v);
                    case "vn":
                        var vn : Array<String> = tail.split(" ");
                        readAttributes(vnData, vn);
                    case "vt":
                        var vt : Array<String> = tail.split(" ");
                        readAttributes(vtData, vt);
                    case "f":
                        var f : Array<String> = tail.split(" ");
                        if (tail.indexOf("/") < 0)
                        {
                            storeAttributes(positions, vData, f, 3);
                        }
                        else
                        {
                            for (fi in f)
                            {
                                if (fi != null && fi != "")
                                {
                                    var values = fi.split("/");
                                
                                    var vi = (Std.parseInt(values[0]) - 1) * 3;
                                    positions.push(vData[vi]);
                                    positions.push(vData[vi + 1]);
                                    positions.push(vData[vi + 2]);
                                    
                                    if (vtData.length != 0)
                                    {
                                        var vti = (Std.parseInt(values[1]) - 1) * 2;
                                        textureCoordinates.push(vtData[vti]);
                                        textureCoordinates.push(vtData[vti + 1]);
                                    }
                                    
                                    if (vnData.length != 0)
                                    {
                                        var vni = (Std.parseInt(values[2]) - 1) * 3;
                                        normals.push(vnData[vni]);
                                        normals.push(vnData[vni + 1]);
                                        normals.push(vnData[vni + 2]);
                                    }
                                }
                            }
                        }
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

        indices = [for(i in 0...Std.int(positions.length / 3)) i];
        
        return {
            positions: positions,
            indices: indices,
            textureCoordinates: textureCoordinates,
            normals: normals
        };
    }

    static function readAttributes(array : Array<Float>, attributes : Array<String>) : Void
    {
        for (a in attributes)
        {
            if (a != null && a != "")
            {
                array.push(Std.parseFloat(a));
            }
        }
    }
    
    static function storeAttributes(array : Array<Float>, data : Array<Float>, indices : Array<String>, count : Int) : Void
    {
        for (i in indices)
        {
            if (i != null && i != "")
            {
                var index = (Std.parseInt(i) - 1) * count;
                array.push(data[index]);
                array.push(data[index + 1]);
                array.push(data[index + 2]);
            }
        }
    }
}

typedef ObjData = {
    positions : Array<Float>,
    indices : Array<Int>,
    textureCoordinates : Array<Float>,
    normals : Array<Float>
}