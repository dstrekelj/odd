package odd.macros;

import haxe.macro.Compiler;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;

class InitMacro
{
    public static macro function initProject() : Expr
    {
        Sys.println("- Initialising Odd project");
        
        var outPath : String = FileSystem.fullPath(Compiler.getOutput());
        var output : CompilerOutput = getCompilerOutput(outPath);
        
        Sys.println("- Creating output directory");
        createOutputDirectory(output);
        
        Sys.println("- Copying assets folder");
        copyAssetsFolder(output);
        
        Sys.println("- Done");

        return null;
    }
    
    private static function copyAssetsFolder(output : CompilerOutput) : Void
    {
        var assetsFolder : String = Compiler.getDefine("odd-assets");
        
        if (assetsFolder == null)
        {
            Sys.println("No assets folder defined");
            return;
        }
        
        if (assetsFolder == "1")
        {
            Sys.println("No assets folder path provided");
            return;
        }
        
        if (!FileSystem.exists(output.filePath + assetsFolder))
        {
            Sys.println("Assets folder does not exist");
            Sys.println("Creating assets folder");
            FileSystem.createDirectory(output.filePath + assetsFolder);
        }
        else
        {
            Sys.println("Found existing assets folder");
        }
        
        var assetsPath : String = FileSystem.fullPath(assetsFolder);
        
        var directory : Array<String> = FileSystem.readDirectory(assetsPath);
        for (item in directory)
        {
            if (!FileSystem.isDirectory(assetsPath + "/" + item))
            {
                Sys.println("Copying to... " + output.filePath + assetsFolder + "/" + item);
                File.copy(assetsPath + "/" + item, output.filePath + assetsFolder + "/" + item);
            }
        }
    }
    
    private static function createOutputDirectory(output : CompilerOutput) : Void
    {
        if (!FileSystem.exists(output.filePath))
        {
            Sys.println("Output directory does not exist");
            Sys.println("Creating output directory");
            
            FileSystem.createDirectory(output.filePath);
        }
        else
        {
            Sys.println("Found existing output directory");
        }
    }
    
    private static function getCompilerOutput(pathToFile : String) : CompilerOutput
    {
        var filePath : String = "";
        var fileName : String = "";
        
        var i = pathToFile.length - 1;
        while (i > 0)
        {
            if (pathToFile.charAt(i) == "\\" || pathToFile.charAt(i) == "/")
            {
                filePath = pathToFile.substr(0, i + 1);
                fileName = pathToFile.substring(i + 1, pathToFile.length);
                break;
            }
            i--;
        }
        
        return { filePath : filePath, fileName : fileName };
    }
}

private typedef CompilerOutput = {
    filePath : String,
    fileName : String
}