package lua;

import llua.Lua;
import llua.State;

class LuaAPI
{
	/* print custom */
	public static function print(state:State):Int
	{
		var msg = Lua.tostring(state, 1);
		trace("[LUA] " + msg);
		return 0;
	}

	/* soma */
	public static function sum(state:State):Int
	{
		var a = Lua.tonumber(state, 1);
		var b = Lua.tonumber(state, 2);

		Lua.pushnumber(state, a + b);
		return 1;
	}

	/* info do app */
	public static function getAppName(state:State):Int
	{
		Lua.pushstring(state, "LuaTools");
		return 1;
	}
}