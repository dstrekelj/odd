package test;

class Main
{
    static function main()
    {
        var testRunner = new haxe.unit.TestRunner();
        testRunner.add(new MatrixTest());
        testRunner.run();
    }
}