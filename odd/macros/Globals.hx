package odd.macros;

@:allow(odd.macros)
class Globals
{
    private static inline var DIRECTORY_ASSETS : String = "assets";
    
    private static var buildDirectory(default, null) : String;
    private static var buildName(default, null) : String;
}