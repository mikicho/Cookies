package;

/**
 * ...
 * @author Michael
 */
class SampleAbstract
{
	var cookies;
    public function new() {
        cookies = new SimpleCookie();        
		Cookie.set("complex", "a=b,b=c");
		var cookiesMap:StringMap<String> = Cookie.all();
		for (name in cookiesMap.keys()) {
			var subValues:Array<String> = cookiesMap.get(name).split(",");
			if (subValues.length > 1) {
				cookies[name] = { };
				for (pair in subValues) {
					cookies[name][pair.split("=")[0]] = pair.split("=")[1];
				}
			}else {
				cookies[name] = subValues[0];
			}	
		}
    }	
}

class SubCookie {
    public function new() {}
    @:keep public function toString()
    	return haxe.Json.stringify(this);
}

abstract SimpleCookie(Dynamic) to Dynamic {
    public inline function new() this = new SubCookie();
	@:arrayAccess function get(key:String):SimpleCookie {
        if (!Reflect.hasField(this, key))
            Reflect.setField(this, key, new SubCookie());
        return Reflect.field(this, key);
    }
    @:arrayAccess function setString(key:String, value:String):String {
        Reflect.setField(this, key, value);
        return value;
    }
	
	@:arrayAccess function setDynamic(key:String, value:Dynamic):Dynamic {
        Reflect.setField(this, key, value);
        return value;
    }
	
    public inline function keys()
		return Reflect.fields(this);
}