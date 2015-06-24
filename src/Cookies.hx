package;

import haxe.ds.StringMap;
import haxe.DynamicAccess;
import js.Cookie;

/**
 * ...
 * @author Michael
 */
@:expose
class Cookies {
	static var simplePairArr:DynamicAccess<CookieValue>;
	static var complexPairArr:DynamicAccess<DynamicAccess<CookieValue>>;
	
    static function main() {
		//Set some cookiesw for tests
		Cookie.set("simple", "sim");
		Cookie.set("complex", "a=b,b=c");
		//Defines two Arrays to contain the cookies for convenient access
		simplePairArr = new DynamicAccess<CookieValue>();
		complexPairArr = new DynamicAccess<DynamicAccess<CookieValue>>();
		//Get Cookies
		var cookiesMap:StringMap<String> = Cookie.all();
		
		for (name in cookiesMap.keys()) {
			//Split each cookie to sub cookies
			var subValues:Array<String> = cookiesMap.get(name).split(",");
			//If subValues.length is big from one it's complex cookie otherwise it's simple one
			if (subValues.length > 1) {
				complexPairArr[name] = new DynamicAccess<CookieValue>(); 
				//Split the complex cookie for sub cookies and insert the subcookies into their structure
				for (pair in subValues) {
					complexPairArr[name][pair.split("=")[0]] = new CookieValue(pair.split("=")[1]);
				}
			}else {
				//Insert the simple cookie into their structure
				simplePairArr[name] = new CookieValue(subValues[0]);
			}
		}
    }
	/*For getting cookies in JS, it's *not* in separate functions for convenient access:
	 *  cookie = Cookies.prototype
	 *  cookie.get("simple")
	 *  cookie.get("complex","b")
	 */ 
	public function get(name:String, ?subName:String):String
	{
		if (subName==null) {			
			return simplePairArr[name].value;
		}else {
			return complexPairArr[name][subName].value;
		}
	}
}