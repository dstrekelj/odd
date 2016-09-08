package odd.rasterizer.tools;

import odd.Color;
import odd.Texture;

class Textures
{
    public static function checkerboard(width : Int, height : Int, fieldSize : Int, field1 : Color, field2 : Color) : Texture
    {
        var texture = new Texture(width, height);

        var color : Color = field1; 
        for (i in 0...(width))
        {
            var x = Math.floor(i / fieldSize) % 2;
            for (j in 0...(height))
            {
                var y = Math.floor(j / fieldSize) % 2;
                if ((x == 0 && y == 0) || (x != 0 && y != 0))
                {
                    color = field1;
                }
                else
                {
                    color = field2;
                }
                texture.setPixel(i, j, color);
            }
        }

        return texture;
    }

    public static function noise(width : Int, height : Int, size : Int) : Texture
    {
        var texture = new Texture(width, height);

        var noise = new Array<Array<Color>>();
        for (i in 0...Math.floor(height / size))
        {
            noise.push([]);
            for (j in 0...Math.floor(width / size))
            {
                var n = Math.random();
                noise[i].push(Color.RGBf(n, n, n));
            }
        }

        for (i in 0...width)
        {
            for (j in 0...height)
            {
                texture.setPixel(i, j, noise[Math.floor(j / size)][Math.floor(i / size)]);
            }
        }

        return texture;
    }

    public static function solid(color : Color) : Texture
    {
        var texture = new Texture(1, 1);

        texture.setPixel(0, 0, color);

        return texture;
    }
}