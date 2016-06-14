package odd._target.java;

import java.awt.Canvas;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.awt.image.BufferStrategy;
import java.javax.swing.JFrame;
import odd._target.java.FrameBufferData;

class Context
{
    var width : Int;
    var height : Int;
    
    var bufferedImage : BufferedImage;
    var canvas : Canvas;
    var bufferStrategy : BufferStrategy;
    var graphics : Graphics;

    public function new(width : Int, height : Int) 
    {
        trace('-- odd.target.java.Context --');
        this.width = width;
        this.height = height;
        
        var size = new Dimension(width, height);
        
        canvas = new Canvas();
        canvas.setPreferredSize(size);
        canvas.setMinimumSize(size);
        canvas.setMaximumSize(size);
        
        bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        
        var frame = new JFrame();
        frame.add(canvas);
        frame.setResizable(false);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setTitle('Odd Software Renderer');
        frame.setVisible(true);
        
        canvas.createBufferStrategy(1);
        bufferStrategy = canvas.getBufferStrategy();
        graphics = canvas.getGraphics();
    }
    
    public function draw(frameBufferData : FrameBufferData) : Void
    {
        while (true)
        {
        bufferedImage.setRGB(0, 0, width, height, frameBufferData, 0, width);
        graphics.drawImage(bufferedImage, 0, 0, width, height, null);
        bufferStrategy.show();
        }
    }
}