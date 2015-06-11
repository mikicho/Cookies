package;

import haxe.ds.StringMap;
import js.Browser;
import js.Cookie;

/**
 * ...
 * @author Michael
 */
@:expose
class Cookies 
{	 
	static var cookies:Dynamic = {};
	static function main() 
	{	 
		Cookie.set("complex", "a=b,b=c");
		var cookiesMap:StringMap<String> = Cookie.all();
		for (name in cookiesMap.keys()) {
			var subValues:Array<String> = cookiesMap.get(name).split(",");
			if (subValues.length > 1) {
				Reflect.setField(cookies, name, { } );
				for (pair in subValues) {
					Reflect.setField(Reflect.getProperty(cookies,name),pair.split("=")[0], pair.split("=")[1]);
				}
			}else {
				Reflect.setField(cookies,name, subValues[0]);
			}	
		}
	}
	
/*	static function set(name:String, value:String, ?expiry:Int, ?path:String, ?domain:String) {				
		Cookie.set(name, value, expiry, path, domain);
	}*/
	
	static function set(name:String, subName:String, value:String, ?expiry:Int, ?path:String, ?domain:String) {
		if (Cookie.exists(name)) {
			if (Reflect.hasField(Reflect.getProperty(cookies, name), subName)) {				
				Reflect.setField(Reflect.getProperty(cookies, name), subName, value);
				Cookie.set(name, cookieToString(name), expiry, path, domain);
			}else {
				trace('no have sub cookie named \'$subName\'');	
			}
		}else {
			trace('no have cookie named \'$name\'');
		}
	}
	
	static private function cookieToString(name:String):String {
		var value:String = "";
		var subCookieObject = Reflect.getProperty(cookies, name);
		var subCookie:Array<String> = Reflect.fields(subCookieObject);		
		for (i in 0...(subCookie.length - 1)) {
			value += subCookie[i] + "=" + Reflect.getProperty(subCookieObject, subCookie[i]) + ",";
		}
		var lastcell:Int = subCookie.length - 1;
		value += subCookie[lastcell] + "=" + Reflect.getProperty(subCookieObject, subCookie[lastcell]);
		return value;
	}
	
	static function remove(name:String, ?path:String, ?domain:String) {				
		Cookie.remove(name, path, domain);
	}
	
	static function alert() {				
		Browser.alert(cookies);
	}
}