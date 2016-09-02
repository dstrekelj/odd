package odd.tools.macros;

import haxe.macro.Compiler;
import haxe.macro.Expr;

import sys.FileSystem;

class Utils
{
    public static macro function getEntryPoint() : Expr
    {
        var args = Sys.args();
        var main = switch (args.indexOf("-main"))
        {
            case -1: "";
            case id: args[id + 1];
        }
        return macro $v{main};
    }

    public static macro function getOutputPath() : Expr
    {
        var output = Compiler.getOutput();

        if (output == "")
        {
            return macro null;
        }

        var output = FileSystem.fullPath(output);
        var position = getLastSlashPosition(output);

        if (position == -1)
        {
            return macro $v{""};
        }
        
        if (output.lastIndexOf(".") != -1)
        {
            output = output.substring(0, position + 1);
        }

        return macro $v{output};
    }

    public static macro function getOutputFileName() : Expr
    {
        var output = Compiler.getOutput();

        if (output == "")
        {
            return macro null;
        }

        if (output.lastIndexOf(".") == -1)
        {
            return macro null;
        }

        var position = getLastSlashPosition(output);

        if (position == -1)
        {
            return macro null;
        }

        return macro $v{output.substr(position + 1, output.length)};
    }

    static function getLastSlashPosition(path : String) : Int
    {
        var position = path.lastIndexOf("/");

        if (position == -1)
        {
            position = path.lastIndexOf("\\");
        }

        return position;
    }
}