package;

/**
 * ...
 * @author Michael
 */
class CookieValue
{
	@:isVar public var value(get, set):String;
	
	public function new(value:String) 
	{
		this.value = value;
	}
	
	function get_value():String 
	{
		return value;
	}
	
	function set_value(value:String):String 
	{
		return this.value = value;
	}
}