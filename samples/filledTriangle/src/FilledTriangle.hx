package;

import odd.Scene;

typedef Point = {
    x : Int,
    y : Int
}

class FilledTriangle extends Scene
{
    var p1 : Point;
    var p2 : Point;
    var p3 : Point;
    
    var p4 : Point;
    var p5 : Point;
    var p6 : Point;
    var p7 : Point;
    
    var r : Int;
    
    var time : Float;
    
    override public function create() : Void
    {
        super.create();
        
        p1 = { x : Std.int(context.width / 2), y : Std.int(context.height / 2) };
        p2 = { x : 0, y : 0 };
        p3 = { x : 0, y : 0 };
        
        p4 = { x : 20, y : 0 };
        p5 = { x : 0, y : 20 };
        p6 = { x : 40, y : 20 };
        p7 = { x : 20, y : 40 };
        
        r = Std.int(context.width / 4);
        
        time = 0;
    }
    
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
        
        time += elapsed;
        
        p2.x = p1.x + Std.int(Math.sin(time) * r);
        p2.y = p1.y + Std.int(Math.cos(time) * r);
        
        p3.x = p1.x + Std.int(Math.sin(time * 2) * r);
        p3.y = p1.y + Std.int(Math.cos(time * 2) * r);
    }
    
    override public function draw() : Void
    {
        super.draw();
        
        drawLine(p1, p2);
        drawLine(p2, p3);
        drawLine(p3, p1);
        
        fillTriangle(p3, p2, p1);
    }
    
    function drawLine(a : Point, b : Point) : Void
    {
        var x : Int = a.x;
        var y : Int = a.y;
        
        var dx : Int = Math.round(Math.abs(b.x - a.x));
        var dy : Int = Math.round(Math.abs(b.y - a.y));
        
        var sx : Int = a.x < b.x ? 1 : -1;
        var sy : Int = a.y < b.y ? 1 : -1;
        
        var e : Float = (dx > dy ? dx : -dy) / 2;
        
        while (x != b.x || y != b.y)
        {
            buffer.setPixel(x, y, 0xffffffff);
            
            var te : Float = e;
            
            if (te > -dx)
            {
                e -= dy;
                x += sx;
            }
            
            if (te < dy)
            {
                e += dx;
                y += sy;
            }
        }
    }
    
    function fillRow(x1 : Int, x2 : Int, y : Int) : Void
    {
        for (column in x1...x2)
        {
            buffer.setPixel(column, y, 0xffffffff);
        }
    }
    
    function fillBottomFlatTriangle(a : Point, b : Point, c : Point) : Void
    {
        if (b.y < a.y && b.y < c.y)
        {
            var t : Point = a;
            a = b;
            b = t;
        }
        else if (c.y < a.y && c.y < b.y)
        {
            var t : Point = a;
            a = c;
            c = t;
        }
        
        if (b.x > c.x)
        {
            var t : Point = b;
            b = c;
            c = t;
        }
        
        if (b.y == c.y)
        {
            var k1 : Float = (b.x - a.x) / (b.y - a.y);
            var k2 : Float = (c.x - a.x) / (c.y - a.y);
            
            var x1 : Float = a.x;
            var x2 : Float = a.x;
            
            for (row in (a.y)...(b.y + 1))
            {
                fillRow(Math.round(x1), Math.round(x2), row);
                x1 += k1;
                x2 += k2;
            }
        }
    }
    
    function fillTopFlatTriangle(a : Point, b : Point, c : Point) : Void
    {
        if (a.y > b.y && a.y > c.y)
        {
            var t : Point = c;
            c = a;
            a = t;
        }
        else if (b.y > a.y && b.y > c.y)
        {
            var t : Point = c;
            c = b;
            b = t;
        }
        
        if (a.x > b.x)
        {
            var t : Point = b;
            b = a;
            a = t;
        }
        
        if (a.y == b.y)
        {
            var k1 : Float = (c.x - a.x) / (c.y - a.y);
            var k2 : Float = (c.x - b.x) / (c.y - b.y);
            
            var x1 : Float = c.x;
            var x2 : Float = c.x;
            
            var row : Int = c.y;
            while (row-- > a.y)
            {
                x1 -= k1;
                x2 -= k2;
                fillRow(Math.round(x1), Math.round(x2), row);
            }
        }
    }
    
    function fillTriangle(a : Point, b : Point, c : Point) : Void
    {
        if (b.y < a.y && b.y < c.y)
        {
            var t : Point = a;
            a = b;
            b = t;
            if (c.y < b.y)
            {
                t = b;
                b = c;
                c = t;
            }
        }
        else if (c.y < a.y && c.y < b.y)
        {
            var t : Point = a;
            a = c;
            c = t;
            if (c.y < b.y)
            {
                t = b;
                b = c;
                c = t;
            }
        }
        else
        {
            if (c.y < b.y)
            {
                var t : Point = b;
                b = c;
                c = t;
            }
        }
        
        if (b.y == c.y)
        {
            fillBottomFlatTriangle(a, b, c);
        }
        else if (a.y == b.y)
        {
            fillTopFlatTriangle(a, b, c);
        }
        else
        {
            var t : Point = {
                x : a.x + Math.round(((b.y - a.y) / (c.y - a.y)) * (c.x - a.x)),
                y : b.y
            };
            fillBottomFlatTriangle(a, b, t);
            fillTopFlatTriangle(b, t, c);
        }
    }
}