package odd.tools.macros;

import haxe.macro.Compiler;
import haxe.macro.Expr;

import odd.tools.macros.Utils;

import sys.FileSystem;

class Project
{
    public static macro function init() : Expr
    {
        if (!Compiler.getDefine("display"))
        {
            Sys.println("Initialising Odd project.");
        
            createOutputDirectory(Utils.getOutputPath());
            
            Sys.println("Done.");
        }

        return null;
    }

    static function createOutputDirectory(path : String) : Void
    {
        Sys.println("Creating output directory");

        if (path == null)
        {
            Sys.println("...No output directory provided.");
            Sys.println("...Aborting.");
            return;
        }

        if (FileSystem.exists(path))
        {
            Sys.println("...Found existing output directory.");
            Sys.println("...Aborting.");
            return;
        }

        Sys.println("...Creating output directory.");
        FileSystem.createDirectory(path);
        
        Sys.println("...Done.");
    }

/*
    static function copyAssetsFolder(path : String) : Void
    {
        var assetsFolder : String = Compiler.getDefine("odd-assets");
        
        if (assetsFolder == null)
        {
            Sys.println("... No assets folder defined");
            return;
        }
        
        if (assetsFolder == "1")
        {
            Sys.println("... No assets folder path provided");
            return;
        }
        
        if (!FileSystem.exists(output.filePath + "assets"))
        {
            Sys.println("... Assets folder does not exist");
            Sys.println("... Creating assets folder");
            FileSystem.createDirectory(output.filePath + "assets");
        }
        else
        {
            Sys.println("... Found existing assets folder");
        }
        
        var assetsPath : String = FileSystem.fullPath(assetsFolder);
        
        var directory : Array<String> = FileSystem.readDirectory(assetsPath);
        for (item in directory)
        {
            if (!FileSystem.isDirectory(assetsPath + "/" + item))
            {
                Sys.println("... Copying to... " + output.filePath + "assets/" + item);
                File.copy(assetsPath + "/" + item, output.filePath + "assets/" + item);
            }
        }
    }
*/
}