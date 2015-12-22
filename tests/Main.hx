package tests;

class Main
{
    static function main()
    {
        var testRunner = new haxe.unit.TestRunner();
        testRunner.add(new Mat4Test());
        testRunner.add(new Vec3Test());
        testRunner.run();
    }
}