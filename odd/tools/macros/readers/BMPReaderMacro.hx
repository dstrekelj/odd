package odd.tools.macros.readers;

class BMPReaderMacro
{
    // Headers
    public var bmpHeader : BMPHeader;
    public var dibHeader : DIBHeader;
    // Color channels (arrays of arrays of integers)
    public var r : Channel;
    public var g : Channel;
    public var b : Channel;
    // Byte data of image file
    var bytes : haxe.io.Bytes;
    // 'Padding byte' count
    var padding : Int;

    /**
    * Organises `bytes` into BMP format structure.
    * @param   bytes   BMP file as bytes
    */
    public function new(bytes : haxe.io.Bytes) 
    {
        this.bytes = bytes;

        var bytesInput = new haxe.io.BytesInput(this.bytes);

        // Populate BMP header
        bmpHeader =
        {
            signature : bytesInput.readString(2),
            fileSize : bytesInput.readInt32(),
            reserved1 : bytesInput.readInt16(),
            reserved2 : bytesInput.readInt16(),
            pixelArrayOffset : bytesInput.readInt32()
        };

        // Populate DIB header
        dibHeader =
        {
            dibHeaderSize : bytesInput.readInt32(),
            imageWidth : bytesInput.readInt32(),
            imageHeight : bytesInput.readInt32(),
            planes : bytesInput.readInt16(),
            bitsPerPixel : bytesInput.readInt16(),
            compression : bytesInput.readInt32(),
            imageSize : bytesInput.readInt32(),
            xPixelsPerMeter : bytesInput.readInt32(),
            yPixelsPerMeter : bytesInput.readInt32(),
            colorsInColorTable : bytesInput.readInt32(),
            importantColorCount : bytesInput.readInt32()
        };

        // Initialise color channels
        r = [for (i in 0...dibHeader.imageHeight) [for (j in 0...dibHeader.imageWidth) 0x00]];
        g = [for (i in 0...dibHeader.imageHeight) [for (j in 0...dibHeader.imageWidth) 0x00]];
        b = [for (i in 0...dibHeader.imageHeight) [for (j in 0...dibHeader.imageWidth) 0x00]];

        var rowSize : Int = Math.floor((dibHeader.bitsPerPixel * dibHeader.imageWidth + 31) / 32) * 4;
        padding = rowSize - dibHeader.imageWidth * 3;

        // Position bytes input handle to pixel array location
        bytesInput.position = bmpHeader.pixelArrayOffset;
        // Populate color channels
        for (row in -(dibHeader.imageHeight - 1)...1)
        {
            for (column in 0...dibHeader.imageWidth)
            {
            b[-row][column] = bytesInput.readByte();
            g[-row][column] = bytesInput.readByte();
            r[-row][column] = bytesInput.readByte();
            }
            bytesInput.read(padding);
        }

        bytesInput.close();
    }

    /**
    * Saves BMP image to `filePath` location.
    * @param   filePath    File location
    */
    public function save(filePath : String) : Void
    {
        // Create new bytes buffer to store changes in
        var buffer = new haxe.io.BytesBuffer();

        for (row in -(dibHeader.imageHeight - 1)...1)
        {
            for (column in 0...dibHeader.imageWidth)
            {
                buffer.addByte(b[-row][column]);
                buffer.addByte(g[-row][column]);
                buffer.addByte(r[-row][column]);
            }
            // Pad row to a multiple of 4 bytes
            for (pad in 0...padding)
            {
                buffer.addByte(0x00);
            }
        }
        // Get buffer as bytes
        var bufferBytes = buffer.getBytes();
        // Put buffer bytes in place of existing bytes
        bytes.blit(bmpHeader.pixelArrayOffset, bufferBytes, 0x00, bufferBytes.length);
        // Save bytes to file
        sys.io.File.saveBytes(filePath, bytes);
    }
}

typedef Channel = Array<Array<Int>>;

private typedef BMPHeader =
{
    var signature : String;
    var fileSize : Int;
    var reserved1 : Int;
    var reserved2 : Int;
    var pixelArrayOffset : Int;
}

private typedef DIBHeader =
{
    var dibHeaderSize : Int;
    var imageWidth : Int;
    var imageHeight : Int;
    var planes : Int;
    var bitsPerPixel : Int;
    var compression : Int;
    var imageSize : Int;
    var xPixelsPerMeter : Int;
    var yPixelsPerMeter : Int;
    var colorsInColorTable : Int;
    var importantColorCount : Int;
}