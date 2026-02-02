package lua;

import llua.Lua;
import llua.State;

class EngineAPI
{
	/* ========================= */
	/* LOG                       */
	/* ========================= */

	public static function log(state:State):Int
	{
		var msg = Lua.tostring(state, 1);
		trace("[ENGINE] " + msg);
		return 0;
	}

	/* ========================= */
	/* TIME                      */
	/* ========================= */

	public static function time(state:State):Int
	{
		Lua.pushnumber(state, Sys.time());
		return 1;
	}

	/* ========================= */
	/* RANDOM                    */
	/* ========================= */

	public static function random(state:State):Int
	{
		var min = Lua.tonumber(state, 1);
		var max = Lua.tonumber(state, 2);

		var value = min + Math.random() * (max - min);
		Lua.pushnumber(state, Math.floor(value));
		return 1;
	}
}