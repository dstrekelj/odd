package odd;
import haxe.io.Bytes;
import haxe.io.BytesData;
import haxe.Timer;

/**
 * ...
 * @author 
 */
class ImageBuffer
{
    public var width(default, null) : Int;
    public var height(default, null) : Int;
    
    var data : Bytes;
    var clearData : Bytes;
    var clearColor : Int;
    
    public function new(width : Int, height : Int)
    {
        this.width = width;
        this.height = height;
        
        data = Bytes.alloc(width * height * 4);
        
        clearColor = 0xff000000;
        clearData = Bytes.alloc(width * height * 4);
        for (i in 0...width) {
            for (j in 0...height) {
                clearData.setInt32(getIndex(i, j), clearColor);
            }
        }
        
        clear();
    }
    
    public inline function clear(?color : Int) : Void
    {
        if (color != null && color != clearColor) {
            for (i in 0...width) {
                for (j in 0...height) {
                    clearData.setInt32(getIndex(i, j), clearColor);
                }
            }
        }
        
        data.blit(0, clearData, 0, clearData.length);
    }
    
    public inline function getData() : BytesData
    {
        return data.getData();
    }
    
    public function getPixel(x : Int, y : Int) : Int
    {
        return getR(x, y) << 24 | getG(x, y) << 16 | getB(x, y) << 8 | getA(x, y);
    }
    
    public inline function getR(x : Int, y : Int) : Int
    {
        return getComponent(x, y, 0);
    }
    
    public inline function getG(x : Int, y : Int) : Int
    {
        return getComponent(x, y, 1);
    }
    
    public inline function getB(x : Int, y : Int) : Int
    {
        return getComponent(x, y, 2);
    }
    
    public inline function getA(x : Int, y : Int) : Int
    {
        return getComponent(x, y, 3);
    }
    
    public function setPixel(x : Int, y : Int, color : Int) : Void
    {
        setR(x, y, (color & 0xff000000) >>> 24);
        setG(x, y, (color & 0x00ff0000) >>> 16);
        setB(x, y, (color & 0x0000ff00) >>> 8);
        setA(x, y, (color & 0x000000ff));
    }
    
    public inline function setR(x : Int, y : Int, r : Int) : Void
    {
        setComponent(x, y, 0, r);
    }
    
    public inline function setG(x : Int, y : Int, g : Int) : Void
    {
        setComponent(x, y, 1, g);
    }
    
    public inline function setB(x : Int, y : Int, b : Int) : Void
    {
        setComponent(x, y, 2, b);
    }
    
    public inline function setA(x : Int, y : Int, a : Int) : Void
    {
        setComponent(x, y, 3, a);
    }
    
    private inline function getComponent(x : Int, y : Int, c : Int) : Int
    {
        return data.get(getIndex(x, y) + c);
    }
    
    private inline function setComponent(x : Int, y : Int, c : Int, v : Int) : Void
    {
        data.set(getIndex(x, y) + c, v);
    }
    
    private inline function getIndex(x : Int, y : Int) : Int
    {
        return (x + y * width) * 4;
    }
}