package lua;

import llua.Lua;
import llua.State;

class EngineAPI
{
	public static function log(state:State):Int
	{
		var msg = Lua.tostring(state, 1);
		trace("[ENGINE] " + msg);
		return 0;
	}

	public static function getTime(state:State):Int
	{
		Lua.pushnumber(state, Sys.time());
		return 1;
	}
}