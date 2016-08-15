package odd.macros;

import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;

class AssetMacro
{
    public static macro function build() : Array<Field>
    {
        Sys.println("- Building assets");
        
        var fields : Array<Field> = Context.getBuildFields();
        
        var assets : Array<String> = FileSystem.readDirectory(Globals.buildDirectory + "/" + Globals.DIRECTORY_ASSETS);
        
        for (asset in assets)
        {
            switch (getExtension(asset))
            {
                case "bmp":
                    Sys.println("Preparing... " + Globals.DIRECTORY_ASSETS + "/" + asset);
                    addAssetField(fields, asset, Globals.DIRECTORY_ASSETS + "/" + asset);
                case a:
                    Sys.println("Skipping... " + asset + " (Unsupported filetype)");
            }
        }
        
        return fields;
    }
    
    private static function getExtension(fileName : String) : String
    {
        return fileName.split(".").pop().toLowerCase();
    }
    
    private static function addAssetField(fields : Array<Field>, identifier : String, value : String) : Void
    {
        identifier = StringTools.replace(identifier, " ", "_");
        identifier = StringTools.replace(identifier, ".", "_");
        fields.push({
            access : [ Access.APublic, Access.AStatic, Access.AInline ],
            kind : FieldType.FVar(macro : odd.geom.Geometry, macro null),
            name : identifier,
            pos : Context.currentPos()
        });
    }
}