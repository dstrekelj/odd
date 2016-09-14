package odd.tools.macros;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

import odd.tools.SysUtils;
import odd.tools.macros.readers.ObjReader;
import odd.tools.macros.readers.ObjReader.ObjData;

import sys.io.File;
import sys.FileSystem;

class Assets
{
    static macro function build() : Array<Field>
    {
        Sys.println("Building assets.");

        var fields = Context.getBuildFields();

        var assetsDirectory = Compiler.getDefine("odd_assets");

        if (assetsDirectory == null)
        {
            Sys.println("...No assets directory set. Skipping.");
            return fields;
        }

        assetsDirectory = SysUtils.trimDirectoryPath(assetsDirectory);
        assetsDirectory = FileSystem.absolutePath(assetsDirectory);

        var localClass = Context.getLocalClass().get();
        
        var assets : Array<String> = FileSystem.readDirectory(assetsDirectory);
        for (asset in assets)
        {
            var assetPath = assetsDirectory + "/" + asset;
            var assetExtension = getAssetExtension(asset).toLowerCase();
            
            var typeExpr = null;

            switch (assetExtension)
            {
                case "obj":
                    Sys.println("...Building " + asset + " as geometry.");
                    typeExpr = makeGeometryType(localClass.pack, assetPath);
                case _:
                    Sys.println("...Skipping " + asset + ". Unsupported format.");
                    continue;
            }

            addField(fields, getAssetName(assetPath), typeExpr);
        }

        Sys.println("Done.");

        return fields;
    }

    static function addField(fields : Array<Field>, name : String, expr : Expr) : Void
    {
        fields.push({
            name: name,
            access: [APublic, AStatic],
            kind: FVar(null, expr),
            pos: Context.currentPos()
        });
    }

    static function makeGeometryType(typePackage : Array<String>, assetPath : String) : Expr
    {
        var typeName = getAssetName(assetPath).toUpperCase();

        var geometryData : ObjData = ObjReader.readPositions(assetPath);

        var typeDefinition = macro class C {
            public static var positions = $v{geometryData.positions};
            public static var indices = $v{geometryData.indices};
        }
        typeDefinition.name = typeName;
        typeDefinition.pack = typePackage.copy();

        Context.defineType(typeDefinition);

        return {
            expr : EConst(CIdent(typeName)),
            pos : Context.currentPos()
        };
    }

    static function getAssetExtension(asset : String) : String
    {
        return asset.split(".").pop();
    }

    static function getAssetName(asset : String) : String
    {
        return asset.split("/").pop().split(".").join("_");
    }
    /*
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
    */
}