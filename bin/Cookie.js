(function (console, $hx_exports) { "use strict";
var CookieValue = function(value) {
	this.set_value(value);
};
CookieValue.prototype = {
	get_value: function() {
		return this.value;
	}
	,set_value: function(value) {
		return this.value = value;
	}
};
var Cookies = $hx_exports.Cookies = function() { };
Cookies.main = function() {
	js_Cookie.set("simple","sim");
	js_Cookie.set("complex","a=b,b=c");
	Cookies.simplePairArr = { };
	Cookies.complexPairArr = { };
	var PairsMap = js_Cookie.all();
	var $it0 = PairsMap.keys();
	while( $it0.hasNext() ) {
		var name = $it0.next();
		var subValues = (__map_reserved[name] != null?PairsMap.getReserved(name):PairsMap.h[name]).split(",");
		if(subValues.length > 1) {
			Cookies.complexPairArr[name] = { };
			var _g = 0;
			while(_g < subValues.length) {
				var pair = subValues[_g];
				++_g;
				var key = pair.split("=")[0];
				var value = new CookieValue(pair.split("=")[1]);
				Cookies.complexPairArr[name][key] = value;
			}
		} else {
			var value1 = new CookieValue(subValues[0]);
			Cookies.simplePairArr[name] = value1;
		}
	}
};
Cookies.prototype = {
	get: function(name,subName) {
		if(subName == null) return Cookies.simplePairArr[name].get_value(); else return Cookies.complexPairArr[name][subName].get_value();
	}
};
var DateTools = function() { };
DateTools.delta = function(d,t) {
	var t1 = d.getTime() + t;
	var d1 = new Date();
	d1.setTime(t1);
	return d1;
};
var HxOverrides = function() { };
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var StringTools = function() { };
StringTools.isSpace = function(s,pos) {
	var c = HxOverrides.cca(s,pos);
	return c > 8 && c < 14 || c == 32;
};
StringTools.ltrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,r)) r++;
	if(r > 0) return HxOverrides.substr(s,r,l - r); else return s;
};
var haxe_IMap = function() { };
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	set: function(key,value) {
		if(__map_reserved[key] != null) this.setReserved(key,value); else this.h[key] = value;
	}
	,setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
	}
	,keys: function() {
		var _this = this.arrayKeys();
		return HxOverrides.iter(_this);
	}
	,arrayKeys: function() {
		var out = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) out.push(key);
		}
		if(this.rh != null) {
			for( var key in this.rh ) {
			if(key.charCodeAt(0) == 36) out.push(key.substr(1));
			}
		}
		return out;
	}
};
var js_Cookie = function() { };
js_Cookie.set = function(name,value,expireDelay,path,domain) {
	var s = name + "=" + encodeURIComponent(value);
	if(expireDelay != null) {
		var d = DateTools.delta(new Date(),expireDelay * 1000);
		s += ";expires=" + d.toGMTString();
	}
	if(path != null) s += ";path=" + path;
	if(domain != null) s += ";domain=" + domain;
	window.document.cookie = s;
};
js_Cookie.all = function() {
	var h = new haxe_ds_StringMap();
	var a = window.document.cookie.split(";");
	var _g = 0;
	while(_g < a.length) {
		var e = a[_g];
		++_g;
		e = StringTools.ltrim(e);
		var t = e.split("=");
		if(t.length < 2) continue;
		h.set(t[0],decodeURIComponent(t[1].split("+").join(" ")));
	}
	return h;
};
var __map_reserved = {}
Cookies.main();
})(typeof console != "undefined" ? console : {log:function(){}}, typeof window != "undefined" ? window : exports);

//# sourceMappingURL=Cookie.js.map