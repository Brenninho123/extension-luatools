package lua;

import llua.Lua;
import llua.State;

class EngineAPIRegister
{
	public static function register(state:State):Void
	{
		// engine = {}
		Lua.newtable(state);

		// engine.log
		Lua.pushcfunction(state, EngineAPI.log);
		Lua.setfield(state, -2, "log");

		// engine.time
		Lua.pushcfunction(state, EngineAPI.time);
		Lua.setfield(state, -2, "time");

		// engine.random
		Lua.pushcfunction(state, EngineAPI.random);
		Lua.setfield(state, -2, "random");

		// engine.app = {}
		Lua.newtable(state);
		Lua.pushstring(state, "LuaTools");
		Lua.setfield(state, -2, "name");
		Lua.pushstring(state, "1.0.0");
		Lua.setfield(state, -2, "version");

		Lua.setfield(state, -2, "app");

		// global engine
		Lua.setglobal(state, "engine");
	}
}