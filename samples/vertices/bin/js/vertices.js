(function (console) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var odd_Engine = function(width,height,framesPerSecond) {
	this.framesPerSecond = framesPerSecond;
	this.timeStep = 1 / framesPerSecond;
	this.timeThen = haxe_Timer.stamp();
	this.timeAccumulator = 0;
	this.context = new odd_Context(width,height);
};
odd_Engine.__name__ = true;
odd_Engine.prototype = {
	run: function(time) {
		this.timeNow = haxe_Timer.stamp();
		this.timeElapsed = this.timeNow - this.timeThen;
		this.timeThen = this.timeNow;
		this.timeAccumulator += this.timeElapsed;
		if(this.timeAccumulator >= this.timeStep) {
			this.context.update(this.timeStep);
			this.timeAccumulator = 0;
		}
		this.context.draw();
		window.requestAnimationFrame($bind(this,this.run));
	}
	,__class__: odd_Engine
};
var Main = function(width,height,framesPerSecond) {
	odd_Engine.call(this,width,height,framesPerSecond);
	this.context.setScene(Vertices);
	this.run();
};
Main.__name__ = true;
Main.main = function() {
	new Main(800,600,60);
};
Main.__super__ = odd_Engine;
Main.prototype = $extend(odd_Engine.prototype,{
	__class__: Main
});
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var StringBuf = function() {
	this.b = "";
};
StringBuf.__name__ = true;
StringBuf.prototype = {
	__class__: StringBuf
};
var Type = function() { };
Type.__name__ = true;
Type.createInstance = function(cl,args) {
	var _g = args.length;
	switch(_g) {
	case 0:
		return new cl();
	case 1:
		return new cl(args[0]);
	case 2:
		return new cl(args[0],args[1]);
	case 3:
		return new cl(args[0],args[1],args[2]);
	case 4:
		return new cl(args[0],args[1],args[2],args[3]);
	case 5:
		return new cl(args[0],args[1],args[2],args[3],args[4]);
	case 6:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5]);
	case 7:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
	case 8:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
	default:
		throw new js__$Boot_HaxeError("Too many arguments");
	}
	return null;
};
var odd_Scene = function(buffer,context) {
	this.buffer = buffer;
	this.context = context;
	console.log("-- NEW SCENE --");
};
odd_Scene.__name__ = true;
odd_Scene.prototype = {
	create: function() {
	}
	,destroy: function() {
	}
	,draw: function() {
	}
	,update: function(delta) {
	}
	,__class__: odd_Scene
};
var Vertices = function(buffer,context) {
	this.time = 0;
	odd_Scene.call(this,buffer,context);
};
Vertices.__name__ = true;
Vertices.__super__ = odd_Scene;
Vertices.prototype = $extend(odd_Scene.prototype,{
	create: function() {
		odd_Scene.prototype.create.call(this);
		this.p1 = new odd_geom_Vertex(200,100,1);
		this.p2 = new odd_geom_Vertex(500,400,3);
		this.p3 = new odd_geom_Vertex(600,200,5);
		var halfWidth = this.context.width / 2;
		var halfHeight = this.context.height / 2;
		this.screenSpace = new odd_math_Mat4(halfWidth,0,0,0,0,-halfHeight,0,0,0,0,1,0,halfWidth,halfHeight,0,1);
		this.projection = odd_math__$Mat4_Matrix4_$Impl_$.projection(0,this.context.width,0,this.context.height,0.1,100);
		this.perspective = new odd_math_Mat4(1 / (this.context.width / 2),0,0,0,0,1 / (this.context.height / 2),0,0,0,0,1,0,this.context.width / 2,this.context.height / 2,0,1);
		this.camera = new odd_math_Mat4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1);
		this.translation = new odd_math_Mat4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,-0.1,1);
		this.scale = new odd_math_Mat4(10,0,0,0,0,10,0,0,0,0,10,0,0,0,0,1);
		var m = new odd_math_Mat4(0.718762,0.615033,-0.324214,0,-0.393732,0.744416,0.539277,0,0.573024,-0.259959,0.777216,0,0.526967,1.254234,-2.53215,1);
		var p = new odd_math_Vec3(-0.5,0.5,-0.5);
		var p_world = new odd_math_Vec3(200,300,10);
		var p_screen = odd_math__$Vec3_Vector3_$Impl_$.multiplyMatrix4(p_world,this.camera);
		p_screen.x /= p_screen.z;
		p_screen.y /= p_screen.z;
		var p_ndc = new odd_math_Vec3(null,null,null);
		p_ndc.x = (p_screen.x + this.context.width / 2) / this.context.width;
		p_ndc.y = (p_screen.y + this.context.height / 2) / this.context.height;
		var p_raster = new odd_math_Vec3(null,null,null);
		p_raster.x = p_ndc.x * this.context.width;
		p_raster.y = p_ndc.y * this.context.height;
		console.log(p_screen);
		console.log(p_ndc);
		console.log(p_raster);
	}
	,update: function(elapsed) {
		odd_Scene.prototype.update.call(this,elapsed);
		this.time += elapsed;
		this.rotation = odd_math__$Mat4_Matrix4_$Impl_$.rotateZ(elapsed);
		this.p1.position = odd_math__$Vec3_Vector3_$Impl_$.multiplyMatrix4(this.p1.position,this.rotation);
		this.p2.position = odd_math__$Vec3_Vector3_$Impl_$.multiplyMatrix4(this.p2.position,this.rotation);
		this.p3.position = odd_math__$Vec3_Vector3_$Impl_$.multiplyMatrix4(this.p3.position,this.rotation);
	}
	,draw: function() {
		odd_Scene.prototype.draw.call(this);
		var p_screen = odd_math__$Vec3_Vector3_$Impl_$.multiplyMatrix4(this.p1.position,this.camera);
		p_screen.x /= p_screen.z;
		p_screen.y /= p_screen.z;
		var p_ndc = new odd_math_Vec3(null,null,null);
		p_ndc.x = (p_screen.x + this.context.width / 2) / this.context.width;
		p_ndc.y = (p_screen.y + this.context.height / 2) / this.context.height;
		var p_raster = new odd_math_Vec3(null,null,null);
		p_raster.x = p_ndc.x * this.context.width;
		p_raster.y = p_ndc.y * this.context.height;
		this.buffer.setPixel(Math.round(p_raster.x),Math.round(p_raster.y),-1);
		var p_screen1 = odd_math__$Vec3_Vector3_$Impl_$.multiplyMatrix4(this.p2.position,this.camera);
		p_screen1.x /= p_screen1.z;
		p_screen1.y /= p_screen1.z;
		var p_ndc1 = new odd_math_Vec3(null,null,null);
		p_ndc1.x = (p_screen1.x + this.context.width / 2) / this.context.width;
		p_ndc1.y = (p_screen1.y + this.context.height / 2) / this.context.height;
		var p_raster1 = new odd_math_Vec3(null,null,null);
		p_raster1.x = p_ndc1.x * this.context.width;
		p_raster1.y = p_ndc1.y * this.context.height;
		this.buffer.setPixel(Math.round(p_raster1.x),Math.round(p_raster1.y),-1);
		var p_screen2 = odd_math__$Vec3_Vector3_$Impl_$.multiplyMatrix4(this.p3.position,this.camera);
		p_screen2.x /= p_screen2.z;
		p_screen2.y /= p_screen2.z;
		var p_ndc2 = new odd_math_Vec3(null,null,null);
		p_ndc2.x = (p_screen2.x + this.context.width / 2) / this.context.width;
		p_ndc2.y = (p_screen2.y + this.context.height / 2) / this.context.height;
		var p_raster2 = new odd_math_Vec3(null,null,null);
		p_raster2.x = p_ndc2.x * this.context.width;
		p_raster2.y = p_ndc2.y * this.context.height;
		this.buffer.setPixel(Math.round(p_raster2.x),Math.round(p_raster2.y),-1);
	}
	,__class__: Vertices
});
var haxe__$Int64__$_$_$Int64 = function(high,low) {
	this.high = high;
	this.low = low;
};
haxe__$Int64__$_$_$Int64.__name__ = true;
haxe__$Int64__$_$_$Int64.prototype = {
	__class__: haxe__$Int64__$_$_$Int64
};
var haxe_Timer = function() { };
haxe_Timer.__name__ = true;
haxe_Timer.stamp = function() {
	return new Date().getTime() / 1000;
};
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
haxe_io_Bytes.__name__ = true;
haxe_io_Bytes.alloc = function(length) {
	return new haxe_io_Bytes(new ArrayBuffer(length));
};
haxe_io_Bytes.ofData = function(b) {
	var hb = b.hxBytes;
	if(hb != null) return hb;
	return new haxe_io_Bytes(b);
};
haxe_io_Bytes.prototype = {
	blit: function(pos,src,srcpos,len) {
		if(pos < 0 || srcpos < 0 || len < 0 || pos + len > this.length || srcpos + len > src.length) throw new js__$Boot_HaxeError(haxe_io_Error.OutsideBounds);
		if(srcpos == 0 && len == src.length) this.b.set(src.b,pos); else this.b.set(src.b.subarray(srcpos,srcpos + len),pos);
	}
	,setInt32: function(pos,v) {
		if(this.data == null) this.data = new DataView(this.b.buffer,this.b.byteOffset,this.b.byteLength);
		this.data.setInt32(pos,v,true);
	}
	,__class__: haxe_io_Bytes
};
var haxe_io_Error = { __ename__ : true, __constructs__ : ["Blocked","Overflow","OutsideBounds","Custom"] };
haxe_io_Error.Blocked = ["Blocked",0];
haxe_io_Error.Blocked.toString = $estr;
haxe_io_Error.Blocked.__enum__ = haxe_io_Error;
haxe_io_Error.Overflow = ["Overflow",1];
haxe_io_Error.Overflow.toString = $estr;
haxe_io_Error.Overflow.__enum__ = haxe_io_Error;
haxe_io_Error.OutsideBounds = ["OutsideBounds",2];
haxe_io_Error.OutsideBounds.toString = $estr;
haxe_io_Error.OutsideBounds.__enum__ = haxe_io_Error;
haxe_io_Error.Custom = function(e) { var $x = ["Custom",3,e]; $x.__enum__ = haxe_io_Error; $x.toString = $estr; return $x; };
var haxe_io_FPHelper = function() { };
haxe_io_FPHelper.__name__ = true;
haxe_io_FPHelper.i32ToFloat = function(i) {
	var sign = 1 - (i >>> 31 << 1);
	var exp = i >>> 23 & 255;
	var sig = i & 8388607;
	if(sig == 0 && exp == 0) return 0.0;
	return sign * (1 + Math.pow(2,-23) * sig) * Math.pow(2,exp - 127);
};
haxe_io_FPHelper.floatToI32 = function(f) {
	if(f == 0) return 0;
	var af;
	if(f < 0) af = -f; else af = f;
	var exp = Math.floor(Math.log(af) / 0.6931471805599453);
	if(exp < -127) exp = -127; else if(exp > 128) exp = 128;
	var sig = Math.round((af / Math.pow(2,exp) - 1) * 8388608) & 8388607;
	return (f < 0?-2147483648:0) | exp + 127 << 23 | sig;
};
haxe_io_FPHelper.i64ToDouble = function(low,high) {
	var sign = 1 - (high >>> 31 << 1);
	var exp = (high >> 20 & 2047) - 1023;
	var sig = (high & 1048575) * 4294967296. + (low >>> 31) * 2147483648. + (low & 2147483647);
	if(sig == 0 && exp == -1023) return 0.0;
	return sign * (1.0 + Math.pow(2,-52) * sig) * Math.pow(2,exp);
};
haxe_io_FPHelper.doubleToI64 = function(v) {
	var i64 = haxe_io_FPHelper.i64tmp;
	if(v == 0) {
		i64.low = 0;
		i64.high = 0;
	} else {
		var av;
		if(v < 0) av = -v; else av = v;
		var exp = Math.floor(Math.log(av) / 0.6931471805599453);
		var sig;
		var v1 = (av / Math.pow(2,exp) - 1) * 4503599627370496.;
		sig = Math.round(v1);
		var sig_l = sig | 0;
		var sig_h = sig / 4294967296.0 | 0;
		i64.low = sig_l;
		i64.high = (v < 0?-2147483648:0) | exp + 1023 << 20 | sig_h;
	}
	return i64;
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else {
		var cl = o.__class__;
		if(cl != null) return cl;
		var name = js_Boot.__nativeClassName(o);
		if(name != null) return js_Boot.__resolveNativeClass(name);
		return null;
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) return true;
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(o instanceof cl) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") return null;
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return (Function("return typeof " + name + " != \"undefined\" ? " + name + " : null"))();
};
var js_html_compat_ArrayBuffer = function(a) {
	if((a instanceof Array) && a.__enum__ == null) {
		this.a = a;
		this.byteLength = a.length;
	} else {
		var len = a;
		this.a = [];
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			this.a[i] = 0;
		}
		this.byteLength = len;
	}
};
js_html_compat_ArrayBuffer.__name__ = true;
js_html_compat_ArrayBuffer.sliceImpl = function(begin,end) {
	var u = new Uint8Array(this,begin,end == null?null:end - begin);
	var result = new ArrayBuffer(u.byteLength);
	var resultArray = new Uint8Array(result);
	resultArray.set(u);
	return result;
};
js_html_compat_ArrayBuffer.prototype = {
	slice: function(begin,end) {
		return new js_html_compat_ArrayBuffer(this.a.slice(begin,end));
	}
	,__class__: js_html_compat_ArrayBuffer
};
var js_html_compat_DataView = function(buffer,byteOffset,byteLength) {
	this.buf = buffer;
	if(byteOffset == null) this.offset = 0; else this.offset = byteOffset;
	if(byteLength == null) this.length = buffer.byteLength - this.offset; else this.length = byteLength;
	if(this.offset < 0 || this.length < 0 || this.offset + this.length > buffer.byteLength) throw new js__$Boot_HaxeError(haxe_io_Error.OutsideBounds);
};
js_html_compat_DataView.__name__ = true;
js_html_compat_DataView.prototype = {
	getInt8: function(byteOffset) {
		var v = this.buf.a[this.offset + byteOffset];
		if(v >= 128) return v - 256; else return v;
	}
	,getUint8: function(byteOffset) {
		return this.buf.a[this.offset + byteOffset];
	}
	,getInt16: function(byteOffset,littleEndian) {
		var v = this.getUint16(byteOffset,littleEndian);
		if(v >= 32768) return v - 65536; else return v;
	}
	,getUint16: function(byteOffset,littleEndian) {
		if(littleEndian) return this.buf.a[this.offset + byteOffset] | this.buf.a[this.offset + byteOffset + 1] << 8; else return this.buf.a[this.offset + byteOffset] << 8 | this.buf.a[this.offset + byteOffset + 1];
	}
	,getInt32: function(byteOffset,littleEndian) {
		var p = this.offset + byteOffset;
		var a = this.buf.a[p++];
		var b = this.buf.a[p++];
		var c = this.buf.a[p++];
		var d = this.buf.a[p++];
		if(littleEndian) return a | b << 8 | c << 16 | d << 24; else return d | c << 8 | b << 16 | a << 24;
	}
	,getUint32: function(byteOffset,littleEndian) {
		var v = this.getInt32(byteOffset,littleEndian);
		if(v < 0) return v + 4294967296.; else return v;
	}
	,getFloat32: function(byteOffset,littleEndian) {
		return haxe_io_FPHelper.i32ToFloat(this.getInt32(byteOffset,littleEndian));
	}
	,getFloat64: function(byteOffset,littleEndian) {
		var a = this.getInt32(byteOffset,littleEndian);
		var b = this.getInt32(byteOffset + 4,littleEndian);
		return haxe_io_FPHelper.i64ToDouble(littleEndian?a:b,littleEndian?b:a);
	}
	,setInt8: function(byteOffset,value) {
		if(value < 0) this.buf.a[byteOffset + this.offset] = value + 128 & 255; else this.buf.a[byteOffset + this.offset] = value & 255;
	}
	,setUint8: function(byteOffset,value) {
		this.buf.a[byteOffset + this.offset] = value & 255;
	}
	,setInt16: function(byteOffset,value,littleEndian) {
		this.setUint16(byteOffset,value < 0?value + 65536:value,littleEndian);
	}
	,setUint16: function(byteOffset,value,littleEndian) {
		var p = byteOffset + this.offset;
		if(littleEndian) {
			this.buf.a[p] = value & 255;
			this.buf.a[p++] = value >> 8 & 255;
		} else {
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p] = value & 255;
		}
	}
	,setInt32: function(byteOffset,value,littleEndian) {
		this.setUint32(byteOffset,value,littleEndian);
	}
	,setUint32: function(byteOffset,value,littleEndian) {
		var p = byteOffset + this.offset;
		if(littleEndian) {
			this.buf.a[p++] = value & 255;
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p++] = value >> 16 & 255;
			this.buf.a[p++] = value >>> 24;
		} else {
			this.buf.a[p++] = value >>> 24;
			this.buf.a[p++] = value >> 16 & 255;
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p++] = value & 255;
		}
	}
	,setFloat32: function(byteOffset,value,littleEndian) {
		this.setUint32(byteOffset,haxe_io_FPHelper.floatToI32(value),littleEndian);
	}
	,setFloat64: function(byteOffset,value,littleEndian) {
		var i64 = haxe_io_FPHelper.doubleToI64(value);
		if(littleEndian) {
			this.setUint32(byteOffset,i64.low);
			this.setUint32(byteOffset,i64.high);
		} else {
			this.setUint32(byteOffset,i64.high);
			this.setUint32(byteOffset,i64.low);
		}
	}
	,__class__: js_html_compat_DataView
};
var js_html_compat_Uint8Array = function() { };
js_html_compat_Uint8Array.__name__ = true;
js_html_compat_Uint8Array._new = function(arg1,offset,length) {
	var arr;
	if(typeof(arg1) == "number") {
		arr = [];
		var _g = 0;
		while(_g < arg1) {
			var i = _g++;
			arr[i] = 0;
		}
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else if(js_Boot.__instanceof(arg1,js_html_compat_ArrayBuffer)) {
		var buffer = arg1;
		if(offset == null) offset = 0;
		if(length == null) length = buffer.byteLength - offset;
		if(offset == 0) arr = buffer.a; else arr = buffer.a.slice(offset,offset + length);
		arr.byteLength = arr.length;
		arr.byteOffset = offset;
		arr.buffer = buffer;
	} else if((arg1 instanceof Array) && arg1.__enum__ == null) {
		arr = arg1.slice();
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else throw new js__$Boot_HaxeError("TODO " + Std.string(arg1));
	arr.subarray = js_html_compat_Uint8Array._subarray;
	arr.set = js_html_compat_Uint8Array._set;
	return arr;
};
js_html_compat_Uint8Array._set = function(arg,offset) {
	var t = this;
	if(js_Boot.__instanceof(arg.buffer,js_html_compat_ArrayBuffer)) {
		var a = arg;
		if(arg.byteLength + offset > t.byteLength) throw new js__$Boot_HaxeError("set() outside of range");
		var _g1 = 0;
		var _g = arg.byteLength;
		while(_g1 < _g) {
			var i = _g1++;
			t[i + offset] = a[i];
		}
	} else if((arg instanceof Array) && arg.__enum__ == null) {
		var a1 = arg;
		if(a1.length + offset > t.byteLength) throw new js__$Boot_HaxeError("set() outside of range");
		var _g11 = 0;
		var _g2 = a1.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			t[i1 + offset] = a1[i1];
		}
	} else throw new js__$Boot_HaxeError("TODO");
};
js_html_compat_Uint8Array._subarray = function(start,end) {
	var t = this;
	var a = js_html_compat_Uint8Array._new(t.slice(start,end));
	a.byteOffset = start;
	return a;
};
var odd_Context = function(width,height) {
	this.width = width;
	this.height = height;
	this.renderBuffer = new odd_ImageBuffer(width,height);
	this.drawBuffer = new odd_ImageBuffer(width,height);
	this.renderer = new OddCanvasRenderer(width,height);
};
odd_Context.__name__ = true;
odd_Context.prototype = {
	update: function(step) {
		if(this.scene != null) this.scene.update(step);
	}
	,draw: function() {
		this.scene.draw();
		this.swapBuffers();
		this.drawBuffer.clear(null);
		this.scene.buffer = this.drawBuffer;
		this.renderer.render(this.renderBuffer.data.b.bufferValue);
	}
	,setScene: function(scene) {
		if(this.scene != null) this.scene.destroy();
		this.scene = Type.createInstance(scene,[this.drawBuffer,this]);
		this.scene.create();
	}
	,swapBuffers: function() {
		var tempBuffer = this.renderBuffer;
		this.renderBuffer = this.drawBuffer;
		this.drawBuffer = tempBuffer;
	}
	,__class__: odd_Context
};
var odd_ImageBuffer = function(width,height) {
	this.width = width;
	this.height = height;
	this.data = haxe_io_Bytes.alloc(width * height * 4);
	this.clearColor = -16777216;
	this.clearData = haxe_io_Bytes.alloc(width * height * 4);
	var _g = 0;
	while(_g < width) {
		var i = _g++;
		var _g1 = 0;
		while(_g1 < height) {
			var j = _g1++;
			this.clearData.setInt32((i + j * this.width) * 4,this.clearColor);
		}
	}
	this.clear(null);
};
odd_ImageBuffer.__name__ = true;
odd_ImageBuffer.prototype = {
	clear: function(color) {
		if(color != null && color != this.clearColor) {
			var _g1 = 0;
			var _g = this.width;
			while(_g1 < _g) {
				var i = _g1++;
				var _g3 = 0;
				var _g2 = this.height;
				while(_g3 < _g2) {
					var j = _g3++;
					this.clearData.setInt32((i + j * this.width) * 4,this.clearColor);
				}
			}
		}
		this.data.blit(0,this.clearData,0,this.clearData.length);
	}
	,getData: function() {
		return this.data.b.bufferValue;
	}
	,getPixel: function(x,y) {
		return this.data.b[(x + y * this.width) * 4] << 24 | this.data.b[(x + y * this.width) * 4 + 1] << 16 | this.data.b[(x + y * this.width) * 4 + 2] << 8 | this.data.b[(x + y * this.width) * 4 + 3];
	}
	,getR: function(x,y) {
		return this.data.b[(x + y * this.width) * 4];
	}
	,getG: function(x,y) {
		return this.data.b[(x + y * this.width) * 4 + 1];
	}
	,getB: function(x,y) {
		return this.data.b[(x + y * this.width) * 4 + 2];
	}
	,getA: function(x,y) {
		return this.data.b[(x + y * this.width) * 4 + 3];
	}
	,setPixel: function(x,y,color) {
		this.data.b[(x + y * this.width) * 4] = (color & -16777216) >>> 24 & 255;
		this.data.b[(x + y * this.width) * 4 + 1] = (color & 16711680) >>> 16 & 255;
		this.data.b[(x + y * this.width) * 4 + 2] = (color & 65280) >>> 8 & 255;
		this.data.b[(x + y * this.width) * 4 + 3] = color & 255 & 255;
	}
	,setR: function(x,y,r) {
		this.data.b[(x + y * this.width) * 4] = r & 255;
	}
	,setG: function(x,y,g) {
		this.data.b[(x + y * this.width) * 4 + 1] = g & 255;
	}
	,setB: function(x,y,b) {
		this.data.b[(x + y * this.width) * 4 + 2] = b & 255;
	}
	,setA: function(x,y,a) {
		this.data.b[(x + y * this.width) * 4 + 3] = a & 255;
	}
	,getComponent: function(x,y,c) {
		return this.data.b[(x + y * this.width) * 4 + c];
	}
	,setComponent: function(x,y,c,v) {
		this.data.b[(x + y * this.width) * 4 + c] = v & 255;
	}
	,getIndex: function(x,y) {
		return (x + y * this.width) * 4;
	}
	,__class__: odd_ImageBuffer
};
var odd_geom_Vertex = function(x,y,z) {
	this.position = new odd_math_Vec3(x,y,z);
};
odd_geom_Vertex.__name__ = true;
odd_geom_Vertex.prototype = {
	__class__: odd_geom_Vertex
};
var odd_math_Mat4 = function(xx,xy,xz,xw,yx,yy,yz,yw,zx,zy,zz,zw,wx,wy,wz,ww) {
	this.xx = xx;
	this.xy = xy;
	this.xz = xz;
	this.xw = xw;
	this.yx = yx;
	this.yy = yy;
	this.yz = yz;
	this.yw = yw;
	this.zx = zx;
	this.zy = zy;
	this.zz = zz;
	this.zw = zw;
	this.wx = wx;
	this.wy = wy;
	this.wz = wz;
	this.ww = ww;
};
odd_math_Mat4.__name__ = true;
odd_math_Mat4.prototype = {
	toString: function() {
		return "{ { " + this.xx + ", " + this.xy + ", " + this.xz + ", " + this.xw + " }, { " + this.yx + ", " + this.yy + ", " + this.yz + ", " + this.yw + " }, { " + this.zx + ", " + this.zy + ", " + this.zz + ", " + this.zw + " }, { " + this.wx + ", " + this.wy + ", " + this.wz + ", " + this.ww + " } }";
	}
	,__class__: odd_math_Mat4
};
var odd_math__$Mat4_Matrix4_$Impl_$ = {};
odd_math__$Mat4_Matrix4_$Impl_$.__name__ = true;
odd_math__$Mat4_Matrix4_$Impl_$._new = function(xx,xy,xz,xw,yx,yy,yz,yw,zx,zy,zz,zw,wx,wy,wz,ww) {
	return new odd_math_Mat4(xx,xy,xz,xw,yx,yy,yz,yw,zx,zy,zz,zw,wx,wy,wz,ww);
};
odd_math__$Mat4_Matrix4_$Impl_$.identity = function() {
	return new odd_math_Mat4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1);
};
odd_math__$Mat4_Matrix4_$Impl_$.empty = function() {
	return new odd_math_Mat4(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
};
odd_math__$Mat4_Matrix4_$Impl_$.translate = function(x,y,z) {
	return new odd_math_Mat4(1,0,0,0,0,1,0,0,0,0,1,0,x,y,z,1);
};
odd_math__$Mat4_Matrix4_$Impl_$.scale = function(x,y,z) {
	return new odd_math_Mat4(x,0,0,0,0,y,0,0,0,0,z,0,0,0,0,1);
};
odd_math__$Mat4_Matrix4_$Impl_$.rotateX = function(a) {
	var c = Math.cos(a);
	var s = Math.sin(a);
	return new odd_math_Mat4(1,0,0,0,0,c,s,0,0,-s,c,0,0,0,0,1);
};
odd_math__$Mat4_Matrix4_$Impl_$.rotateY = function(a) {
	var c = Math.cos(a);
	var s = Math.sin(a);
	return new odd_math_Mat4(c,0,-s,0,0,1,0,0,s,0,c,0,0,0,0,1);
};
odd_math__$Mat4_Matrix4_$Impl_$.rotateZ = function(a) {
	var c = Math.cos(a);
	var s = Math.sin(a);
	return new odd_math_Mat4(c,s,0,0,-s,c,0,0,0,0,1,0,0,0,0,1);
};
odd_math__$Mat4_Matrix4_$Impl_$.rotate = function(roll,pitch,yaw) {
	var cx = Math.cos(roll);
	var sx = Math.sin(roll);
	var cy = Math.cos(pitch);
	var sy = Math.sin(pitch);
	var cz = Math.cos(yaw);
	var sz = Math.sin(yaw);
	return new odd_math_Mat4(cz * cy,sz * sy,-sy,0,cz * sy * sx - sz * cx,sz * sy * sx + cz * cx,cy * sx,0,cz * sy * cx + sz * sx,sz * sy * cx - cz * sx,cy * cx,0,0,0,0,1);
};
odd_math__$Mat4_Matrix4_$Impl_$.screenSpace = function(halfWidth,halfHeight) {
	return new odd_math_Mat4(halfWidth,0,0,0,0,-halfHeight,0,0,0,0,1,0,halfWidth,halfHeight,0,1);
};
odd_math__$Mat4_Matrix4_$Impl_$.perspective = function(fieldOfView,aspectRatio,near,far) {
	var t = Math.tan(fieldOfView / 2);
	var r = near - far;
	return new odd_math_Mat4(1 / (t * aspectRatio),0,0,0,0,1 / t,0,0,0,0,(-near - far) / r,2 * near * far / r,0,0,1,0);
};
odd_math__$Mat4_Matrix4_$Impl_$.projection = function(left,right,top,bottom,near,far) {
	return new odd_math_Mat4(2 * near / (right - left),0,(right + left) / (right - left),0,0,2 * near / (top - bottom),(top + bottom) / (top - bottom),0,0,0,-(far + near) / (far - near),-(2 * far * near) / (far - near),0,0,1,0);
};
odd_math__$Mat4_Matrix4_$Impl_$.negate = function(this1) {
	return new odd_math_Mat4(-this1.xx,-this1.xy,-this1.xz,-this1.xw,-this1.yx,-this1.yy,-this1.yz,-this1.yw,-this1.zx,-this1.zy,-this1.zz,-this1.zw,-this1.wx,-this1.wy,-this1.wz,-this1.ww);
};
odd_math__$Mat4_Matrix4_$Impl_$.add = function(this1,B) {
	return new odd_math_Mat4(this1.xx + B.xx,this1.xy + B.xy,this1.xz + B.xz,this1.xw + B.xw,this1.yx + B.yx,this1.yy + B.yy,this1.yz + B.yz,this1.yw + B.yw,this1.zx + B.zx,this1.zy + B.zy,this1.zz + B.zz,this1.zw + B.zw,this1.wx + B.wx,this1.wy + B.wy,this1.wz + B.wz,this1.ww + B.ww);
};
odd_math__$Mat4_Matrix4_$Impl_$.subtract = function(this1,B) {
	return new odd_math_Mat4(this1.xx - B.xx,this1.xy - B.xy,this1.xz - B.xz,this1.xw - B.xw,this1.yx - B.yx,this1.yy - B.yy,this1.yz - B.yz,this1.yw - B.yw,this1.zx - B.zx,this1.zy - B.zy,this1.zz - B.zz,this1.zw - B.zw,this1.wx - B.wx,this1.wy - B.wy,this1.wz - B.wz,this1.ww - B.ww);
};
odd_math__$Mat4_Matrix4_$Impl_$.multiplyScalar = function(this1,B) {
	return new odd_math_Mat4(this1.xx * B,this1.xy * B,this1.xz * B,this1.xw * B,this1.yx * B,this1.yy * B,this1.yz * B,this1.yw * B,this1.zx * B,this1.zy * B,this1.zz * B,this1.zw * B,this1.wx * B,this1.wy * B,this1.wz * B,this1.ww * B);
};
odd_math__$Mat4_Matrix4_$Impl_$.multiplyMatrix = function(this1,B) {
	return new odd_math_Mat4(this1.xx * B.xx + this1.xy * B.yx + this1.xz * B.zx + this1.xw * B.wx,this1.xx * B.xy + this1.xy * B.yy + this1.xz * B.zy + this1.xw * B.wy,this1.xx * B.xz + this1.xy * B.yz + this1.xz * B.zz + this1.xw * B.wz,this1.xx * B.xw + this1.xy * B.yw + this1.xz * B.zw + this1.xw * B.ww,this1.yx * B.xx + this1.yy * B.yx + this1.yz * B.zx + this1.yw * B.wx,this1.yx * B.xy + this1.yy * B.yy + this1.yz * B.zy + this1.yw * B.wy,this1.yx * B.xz + this1.yy * B.yz + this1.yz * B.zz + this1.yw * B.wz,this1.yx * B.xw + this1.yy * B.yw + this1.yz * B.zw + this1.yw * B.ww,this1.zx * B.xx + this1.zy * B.yx + this1.zz * B.zx + this1.zw * B.wx,this1.zx * B.xy + this1.zy * B.yy + this1.zz * B.zy + this1.zw * B.wy,this1.zx * B.xz + this1.zy * B.yz + this1.zz * B.zz + this1.zw * B.wz,this1.zx * B.xw + this1.zy * B.yw + this1.zz * B.zw + this1.zw * B.ww,this1.wx * B.xx + this1.wy * B.yx + this1.wz * B.zx + this1.ww * B.wx,this1.wx * B.xy + this1.wy * B.yy + this1.wz * B.zy + this1.ww * B.wy,this1.wx * B.xz + this1.wy * B.yz + this1.wz * B.zz + this1.ww * B.wz,this1.wx * B.xw + this1.wy * B.yw + this1.wz * B.zw + this1.ww * B.ww);
};
var odd_math_Vec3 = function(x,y,z) {
	if(z == null) z = 0;
	if(y == null) y = 0;
	if(x == null) x = 0;
	this.x = x;
	this.y = y;
	this.z = z;
};
odd_math_Vec3.__name__ = true;
odd_math_Vec3.prototype = {
	toString: function() {
		return "{ " + this.x + ", " + this.y + ", " + this.z + " }";
	}
	,__class__: odd_math_Vec3
};
var odd_math__$Vec3_Vector3_$Impl_$ = {};
odd_math__$Vec3_Vector3_$Impl_$.__name__ = true;
odd_math__$Vec3_Vector3_$Impl_$.get_length = function(this1) {
	return Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z);
};
odd_math__$Vec3_Vector3_$Impl_$._new = function(x,y,z) {
	return new odd_math_Vec3(x,y,z);
};
odd_math__$Vec3_Vector3_$Impl_$.negate = function(this1) {
	return new odd_math_Vec3(-this1.x,-this1.y,-this1.z);
};
odd_math__$Vec3_Vector3_$Impl_$.add = function(this1,B) {
	return new odd_math_Vec3(this1.x + B.x,this1.y + B.y,this1.z + B.z);
};
odd_math__$Vec3_Vector3_$Impl_$.subtract = function(this1,B) {
	return new odd_math_Vec3(this1.x - B.x,this1.y - B.y,this1.z - B.z);
};
odd_math__$Vec3_Vector3_$Impl_$.multiplyScalar = function(this1,B) {
	return new odd_math_Vec3(this1.x * B,this1.y * B,this1.z * B);
};
odd_math__$Vec3_Vector3_$Impl_$.multiplyMatrix4 = function(this1,B) {
	var v = new odd_math_Vec3(null,null,null);
	v.x = this1.x * B.xx + this1.y * B.yx + this1.z * B.zx + B.wx;
	v.y = this1.x * B.xy + this1.y * B.yy + this1.z * B.zy + B.wy;
	v.z = this1.x * B.xz + this1.y * B.yz + this1.z * B.zz + B.wz;
	var w = this1.x * B.xw + this1.y * B.yw + this1.z * B.zw + B.ww;
	if(w != 1 && w != 0) {
		v.x /= w;
		v.y /= w;
		v.z /= w;
	}
	return v;
};
odd_math__$Vec3_Vector3_$Impl_$.divide = function(this1,B) {
	return new odd_math_Vec3(this1.x / B,this1.y / B,this1.z / B);
};
odd_math__$Vec3_Vector3_$Impl_$.dotProduct = function(this1,B) {
	return this1.x * B.x + this1.y * B.y + this1.z * B.z;
};
odd_math__$Vec3_Vector3_$Impl_$.crossProduct = function(this1,B) {
	return new odd_math_Vec3(this1.y * B.z - this1.z * B.y,this1.z * B.x - this1.x * B.z,this1.x * B.y - this1.y * B.x);
};
odd_math__$Vec3_Vector3_$Impl_$.normalize = function(this1) {
	var x = this1.x / Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z);
	var y = this1.y / Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z);
	var z = this1.z / Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z);
	return new odd_math_Vec3(x,y,z);
};
var odd_math_Vec4 = function(x,y,z,w) {
	if(w == null) w = 1;
	if(z == null) z = 0;
	if(y == null) y = 0;
	if(x == null) x = 0;
	this.x = x;
	this.y = y;
	this.z = z;
	this.w = w;
};
odd_math_Vec4.__name__ = true;
odd_math_Vec4.prototype = {
	toString: function() {
		return "{ " + this.x + ", " + this.y + ", " + this.z + ", " + this.w + " }";
	}
	,__class__: odd_math_Vec4
};
var odd_math__$Vec4_Vector4_$Impl_$ = {};
odd_math__$Vec4_Vector4_$Impl_$.__name__ = true;
odd_math__$Vec4_Vector4_$Impl_$.get_length = function(this1) {
	return Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z + this1.w * this1.w);
};
odd_math__$Vec4_Vector4_$Impl_$._new = function(x,y,z,w) {
	return new odd_math_Vec4(x,y,z,w);
};
odd_math__$Vec4_Vector4_$Impl_$.negate = function(this1) {
	return new odd_math_Vec4(-this1.x,-this1.y,-this1.z,-this1.w);
};
odd_math__$Vec4_Vector4_$Impl_$.add = function(this1,B) {
	return new odd_math_Vec4(this1.x + B.x,this1.y + B.y,this1.z + B.z,this1.w + B.w);
};
odd_math__$Vec4_Vector4_$Impl_$.subtract = function(this1,B) {
	return new odd_math_Vec4(this1.x - B.x,this1.y - B.y,this1.z - B.z,this1.w - B.w);
};
odd_math__$Vec4_Vector4_$Impl_$.multiplyScalar = function(this1,B) {
	return new odd_math_Vec4(this1.x * B,this1.y * B,this1.z * B,this1.w * B);
};
odd_math__$Vec4_Vector4_$Impl_$.multiplyMatrix4 = function(this1,B) {
	return new odd_math_Vec4(B.xx * this1.x + B.yx * this1.y + B.zx * this1.z + B.wx * this1.w,B.xy * this1.x + B.yy * this1.y + B.zy * this1.z + B.wy * this1.w,B.xz * this1.x + B.yz * this1.y + B.zz * this1.z + B.wz * this1.w,B.xw * this1.x + B.yw * this1.y + B.zw * this1.z + B.ww * this1.w);
};
odd_math__$Vec4_Vector4_$Impl_$.divide = function(this1,B) {
	return new odd_math_Vec4(this1.x / B,this1.y / B,this1.z / B,this1.w / B);
};
odd_math__$Vec4_Vector4_$Impl_$.dotProduct = function(this1,B) {
	return this1.x * B.x + this1.y * B.y + this1.z * B.z + this1.w * B.w;
};
odd_math__$Vec4_Vector4_$Impl_$.normalize = function(this1) {
	var x = this1.x / Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z + this1.w * this1.w);
	var y = this1.y / Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z + this1.w * this1.w);
	var z = this1.z / Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z + this1.w * this1.w);
	var w = this1.w / Math.sqrt(this1.x * this1.x + this1.y * this1.y + this1.z * this1.z + this1.w * this1.w);
	return new odd_math_Vec4(x,y,z,w);
};
var odd_renderers_js_CanvasRenderer = function(width,height) {
	console.log("-- CanvasRenderer --");
	this.width = width;
	this.height = height;
	var document = window.document;
	var canvas = document.createElement("canvas");
	this.context = canvas.getContext("2d",null);
	canvas.setAttribute("width",width == null?"null":"" + width);
	canvas.setAttribute("height",height == null?"null":"" + height);
	document.body.appendChild(canvas);
};
odd_renderers_js_CanvasRenderer.__name__ = true;
odd_renderers_js_CanvasRenderer.prototype = {
	render: function(bufferData) {
		this.pixelArray = new Uint8ClampedArray(bufferData);
		this.imageData = new ImageData(this.pixelArray,this.width,this.height);
		this.context.putImageData(this.imageData,0,0);
	}
	,__class__: odd_renderers_js_CanvasRenderer
};
var odd_renderers_neko_NekoAsciiRenderer = function(width,height) {
	this.width = width;
	this.height = height;
};
odd_renderers_neko_NekoAsciiRenderer.__name__ = true;
odd_renderers_neko_NekoAsciiRenderer.prototype = {
	render: function(bufferData) {
		this.image = new StringBuf();
		this.bytes = haxe_io_Bytes.ofData(bufferData);
		var _g1 = 0;
		var _g = this.height;
		while(_g1 < _g) {
			var row = _g1++;
			var _g3 = 0;
			var _g2 = this.width;
			while(_g3 < _g2) {
				var col = _g3++;
				this.putChar(this.bytes.b[(col + row * this.width) * 4],this.bytes.b[(col + row * this.width) * 4 + 1],this.bytes.b[(col + row * this.width) * 4 + 2]);
			}
			this.image.b += "\n";
		}
	}
	,putChar: function(r,g,b) {
		var value = r + g + b;
		if(value >= 567) this.image.b += String.fromCharCode(178); else if(value >= 378) this.image.b += String.fromCharCode(176); else if(value >= 189) this.image.b += String.fromCharCode(177); else this.image.b += String.fromCharCode(32);
	}
	,__class__: odd_renderers_neko_NekoAsciiRenderer
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
Date.prototype.__class__ = Date;
Date.__name__ = ["Date"];
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
var ArrayBuffer = (Function("return typeof ArrayBuffer != 'undefined' ? ArrayBuffer : null"))() || js_html_compat_ArrayBuffer;
if(ArrayBuffer.prototype.slice == null) ArrayBuffer.prototype.slice = js_html_compat_ArrayBuffer.sliceImpl;
var DataView = (Function("return typeof DataView != 'undefined' ? DataView : null"))() || js_html_compat_DataView;
var Uint8Array = (Function("return typeof Uint8Array != 'undefined' ? Uint8Array : null"))() || js_html_compat_Uint8Array._new;
haxe_io_FPHelper.i64tmp = (function($this) {
	var $r;
	var x = new haxe__$Int64__$_$_$Int64(0,0);
	$r = x;
	return $r;
}(this));
js_Boot.__toStr = {}.toString;
js_html_compat_Uint8Array.BYTES_PER_ELEMENT = 1;
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
