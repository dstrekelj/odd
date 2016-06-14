package odd;

#if java
typedef FrameBufferData = odd._target.java.FrameBufferData;
#elseif js
typedef FrameBufferData = odd._target.js.FrameBufferData;
#else
typedef FrameBufferData = Array<Int>;
#end