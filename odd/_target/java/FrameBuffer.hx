package odd._target.java;

import odd._target.java.FrameBufferData;

class FrameBuffer
{
    var width : Int;
    var height : Int;
    var data : FrameBufferData;
    
    public function new(width : Int, height : Int) 
    {
        this.width = width;
        this.height = height;
        this.data = new FrameBufferData(width * height);
    }
    
    public inline function clear(rgba : Int) : Void
    {
        for (x in 0...width)
        {
            for (y in 0...height)
            {
                setPixel(x, y, rgba);
            }
        }
    }
    
    public inline function getData() : FrameBufferData
    {
        return data;
    }
    
    public inline function getPixel(x : Int, y : Int) : Int
    {
        return data[getIndex(x, y)];
    }
    
    public inline function getR(x : Int, y : Int) : Int
    {
        return read(x, y, 2);
    }
    
    public inline function getG(x : Int, y : Int) : Int
    {
        return read(x, y, 1);
    }
    
    public inline function getB(x : Int, y : Int) : Int
    {
        return read(x, y, 0);
    }
    
    public inline function getA(x : Int, y : Int) : Int
    {
        return read(x, y, 3);
    }
    
    public inline function setPixel(x : Int, y : Int, rgba : Int) : Void
    {
        setR(x, y, (rgba >> 24) & 0xff);
        setG(x, y, (rgba >> 16) & 0xff);
        setB(x, y, (rgba >> 8) & 0xff);
        setA(x, y, rgba & 0xff);
    }
    
    public inline function setR(x : Int, y : Int, r : Int) : Void
    {
        write(x, y, 2, r);
    }
    
    public inline function setG(x : Int, y : Int, g : Int) : Void
    {
        write(x, y, 1, g);
    }
    
    public inline function setB(x : Int, y : Int, b : Int) : Void
    {
        write(x, y, 0, b);
    }
    
    public inline function setA(x : Int, y : Int, a : Int) : Void
    {
        write(x, y, 3, a);
    }
    
    private inline function read(x : Int, y : Int, c : Int) : Int
    {
        return (data[getIndex(x, y)] >> (c * 8) & 0xff);
    }
    
    private inline function write(x : Int, y : Int, c : Int, v : Int) : Void
    {
        data[getIndex(x, y)] = (data[getIndex(x, y)] & ~(0xff << (c * 8))) | (v << (c * 8));
    }
    
    private inline function getIndex(x : Int, y : Int) : Int
    {
        return (x + y * width);
    }
}