(function (console) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std["int"] = function(x) {
	return x | 0;
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
	this.renderer = new odd_renderers_js_CanvasRenderer(width,height);
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
var odd_renderers_js_CanvasRenderer = function(width,height) {
	console.log("new canvas context");
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
var samples_Starfield = function(buffer,context) {
	odd_Scene.call(this,buffer,context);
};
samples_Starfield.__name__ = true;
samples_Starfield.__super__ = odd_Scene;
samples_Starfield.prototype = $extend(odd_Scene.prototype,{
	create: function() {
		odd_Scene.prototype.create.call(this);
		this.spread = 64;
		this.speed = 32;
		var _g = [];
		var _g1 = 0;
		while(_g1 < 256) {
			var i = _g1++;
			_g.push({ x : 2 * (Math.random() - 0.5) * this.spread, y : 2 * (Math.random() - 0.5) * this.spread, z : Math.random() * this.spread});
		}
		this.stars = _g;
	}
	,update: function(elapsed) {
		odd_Scene.prototype.update.call(this,elapsed);
		var halfWidth = this.context.width / 2;
		var halfHeight = this.context.height / 2;
		var _g = 0;
		var _g1 = this.stars;
		while(_g < _g1.length) {
			var star = _g1[_g];
			++_g;
			star.z -= elapsed * this.speed;
			if(star.z <= 0) {
				star.x = 2 * (Math.random() - 0.5) * this.spread;
				star.y = 2 * (Math.random() - 0.5) * this.spread;
				star.z = Math.random() * this.spread;
			}
			var x = Math.floor(star.x / star.z * halfWidth + halfWidth);
			var y = Math.floor(star.y / star.z * halfHeight + halfHeight);
			if(x < 0 || x >= this.context.width || y < 0 || y >= this.context.height) {
				star.x = 2 * (Math.random() - 0.5) * this.spread;
				star.y = 2 * (Math.random() - 0.5) * this.spread;
				star.z = Math.random() * this.spread;
			} else this.buffer.setPixel(x,y,-1);
		}
	}
	,draw: function() {
		odd_Scene.prototype.draw.call(this);
	}
	,__class__: samples_Starfield
});
var samples_Triangle = function(buffer,context) {
	odd_Scene.call(this,buffer,context);
};
samples_Triangle.__name__ = true;
samples_Triangle.__super__ = odd_Scene;
samples_Triangle.prototype = $extend(odd_Scene.prototype,{
	create: function() {
		odd_Scene.prototype.create.call(this);
		this.p1 = { x : this.context.width / 2 | 0, y : this.context.height / 2 | 0};
		this.p2 = { x : 0, y : 0};
		this.p3 = { x : 0, y : 0};
		this.time = 0;
	}
	,update: function(elapsed) {
		odd_Scene.prototype.update.call(this,elapsed);
		this.time += elapsed;
		this.p2.x = this.p1.x + Std["int"](Math.sin(this.time) * 100);
		this.p2.y = this.p1.y + Std["int"](Math.cos(this.time) * 100);
		this.p3.x = this.p1.x + Std["int"](Math.sin(this.time * 2) * 100);
		this.p3.y = this.p1.y + Std["int"](Math.cos(this.time * 2) * 100);
	}
	,draw: function() {
		odd_Scene.prototype.draw.call(this);
		this.drawLine(this.p1,this.p2);
		this.drawLine(this.p2,this.p3);
		this.drawLine(this.p3,this.p1);
	}
	,drawLine: function(a,b) {
		var x = a.x;
		var y = a.y;
		var dx = Math.round(Math.abs(b.x - a.x));
		var dy = Math.round(Math.abs(b.y - a.y));
		var sx;
		if(a.x < b.x) sx = 1; else sx = -1;
		var sy;
		if(a.y < b.y) sy = 1; else sy = -1;
		var e;
		e = (dx > dy?dx:-dy) / 2;
		while(true) {
			this.buffer.setPixel(x,y,-1);
			if(x == b.x && y == b.y) break;
			var te = e;
			if(te > -dx) {
				e -= dy;
				x += sx;
			}
			if(te < dy) {
				e += dx;
				y += sy;
			}
		}
	}
	,__class__: samples_Triangle
});
var test_Main = function(width,height,framesPerSecond) {
	odd_Engine.call(this,width,height,framesPerSecond);
	this.context.setScene(samples_Triangle);
	this.run();
};
test_Main.__name__ = true;
test_Main.main = function() {
	new test_Main(800,600,60);
};
test_Main.__super__ = odd_Engine;
test_Main.prototype = $extend(odd_Engine.prototype,{
	__class__: test_Main
});
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
test_Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
