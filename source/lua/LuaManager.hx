package lua;

import llua.Lua;
import llua.LuaL;
import llua.State;
import llua.Convert;

class LuaManager
{
	public var state:State;
	var scriptPath:String;

	public function new(path:String)
	{
		scriptPath = path;
		createState();
	}

	/* ========================= */
	/* STATE                     */
	/* ========================= */

	function createState():Void
	{
		state = LuaL.newstate();
		LuaL.openlibs(state);
	}

	function destroyState():Void
	{
		Lua.close(state);
	}

	/* ========================= */
	/* LOAD / RELOAD             */
	/* ========================= */

	public function load():Void
	{
		if (LuaL.dofile(state, scriptPath) != 0)
			error();
	}

	public function reload():Void
	{
		trace("♻ Hot Reload Lua...");

		destroyState();
		createState();

		load();

		// Chama callback de reload se existir
		call("onReload", []);
	}

	/* ========================= */
	/* CALLS                     */
	/* ========================= */

	public function call(func:String, args:Array<Dynamic>):Dynamic
	{
		Lua.getglobal(state, func);

		if (!Lua.isfunction(state, -1))
		{
			Lua.pop(state, 1);
			return null;
		}

		for (a in args)
			Convert.toLua(state, a);

		if (Lua.pcall(state, args.length, 1, 0) != 0)
		{
			error();
			return null;
		}

		return Convert.fromLua(state, -1);
	}

	/* ========================= */
	/* API                       */
	/* ========================= */

	public function exposeFunction(name:String, fn:State->Int):Void
	{
		Lua.pushcfunction(state, fn);
		Lua.setglobal(state, name);
	}

	/* ========================= */
	/* ERROR                     */
	/* ========================= */

	function error():Void
	{
		trace("Lua Error: " + Lua.tostring(state, -1));
		Lua.pop(state, 1);
	}
}