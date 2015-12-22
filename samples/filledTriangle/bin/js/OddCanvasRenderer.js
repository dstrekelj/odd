(function(window) {
    
    function OddCanvasRenderer(width, height) {
        
        console.log('-- OddCanvasRenderer --');
        
        this.width = width;
        this.height = height;
        
        var canvas = document.createElement('canvas');
        canvas.setAttribute('width', width + 'px');
        canvas.setAttribute('height', height + 'px');
        document.body.appendChild(canvas);

        this.context = canvas.getContext('2d');

    }

    OddCanvasRenderer.prototype.render = function(bufferData) {

        var pixelArray = new Uint8ClampedArray(bufferData);
        var imageData = new ImageData(pixelArray, this.width, this.height);
        this.context.putImageData(imageData, 0, 0);

    }
    
    window.OddCanvasRenderer = OddCanvasRenderer;
    
})(window);