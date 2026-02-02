package lua;

import llua.Lua;
import llua.LuaL;
import llua.State;
import llua.Convert;

class LuaManager
{
	public var state:State;

	public function new()
	{
		state = LuaL.newstate();
		LuaL.openlibs(state);

		trace("Lua iniciado");
	}

	/* ========================= */
	/* EXECUÇÃO                  */
	/* ========================= */

	public function runString(code:String):Void
	{
		if (LuaL.dostring(state, code) != 0)
			error();
	}

	public function runFile(path:String):Void
	{
		if (LuaL.dofile(state, path) != 0)
			error();
	}

	private function error():Void
	{
		trace("Lua Error: " + Lua.tostring(state, -1));
		Lua.pop(state, 1);
	}

	/* ========================= */
	/* VARIÁVEIS                 */
	/* ========================= */

	public function setGlobal(name:String, value:Dynamic):Void
	{
		Convert.toLua(state, value);
		Lua.setglobal(state, name);
	}

	public function getGlobal(name:String):Dynamic
	{
		Lua.getglobal(state, name);
		return Convert.fromLua(state, -1);
	}

	/* ========================= */
	/* FUNÇÕES LUA               */
	/* ========================= */

	public function call(func:String, args:Array<Dynamic>):Dynamic
	{
		Lua.getglobal(state, func);

		for (arg in args)
			Convert.toLua(state, arg);

		if (Lua.pcall(state, args.length, 1, 0) != 0)
		{
			error();
			return null;
		}

		return Convert.fromLua(state, -1);
	}

	/* ========================= */
	/* EXPOR API HAXE -> LUA     */
	/* ========================= */

	public function exposeFunction(name:String, fn:State->Int):Void
	{
		Lua.pushcfunction(state, fn);
		Lua.setglobal(state, name);
	}
}