package odd.tools;

import sys.io.Process;
import sys.FileSystem;

class SysUtils
{
    public static function getHaxelibPath(haxelib : String) : String
    {
        var process = new Process("haxelib", ["path", haxelib]);
        var line : String = null;

        try
        {
            while ((line = process.stdout.readLine()) != "")
            {
                if (line.charAt(0) != "-")
                {
                    break;
                }
            }
        }
        catch (e : haxe.io.Eof)
        {
            Sys.println("ERROR: Could not find lib path");
        }
        
        process.close();

        return line;
    }

    public static function purgeDirectory(path : String) : Void
    {
        if (FileSystem.exists(path) && FileSystem.isDirectory(path))
        {
            var items : Array<String> = FileSystem.readDirectory(path);
            for (item in items)
            {
                var itemPath = path + "/" + item;
                if (FileSystem.isDirectory(itemPath))
                {
                    purgeDirectory(itemPath);
                    FileSystem.deleteDirectory(itemPath);
                }
                else
                {
                    FileSystem.deleteFile(itemPath);
                }
            }
        }
    }

    public static function trimDirectoryPath(path : String) : String
    {
        var newPath = new StringBuf();
        var foundSlash = false; 
        
        for (i in 0...path.length)
        {
            var char = path.charAt(i);
            
            if (char == "/" || char == "\\")
            {
                if (foundSlash) continue;
                foundSlash = true;
            }
            else
            {
                foundSlash = false;
            }
            
            newPath.add(char);
        }

        if (!(StringTools.endsWith(path, "/") || StringTools.endsWith(path, "\\")))
        {
            newPath.add("/");
        }

        return newPath.toString();
    }
}