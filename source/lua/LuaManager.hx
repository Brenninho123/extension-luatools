package lua;

import llua.Lua;
import llua.State;
import llua.Convert;
import sys.io.File;

class LuaManager
{
	public var state:State;

	public function new()
	{
		state = LuaL.newstate();
		LuaL.openlibs(state);

		trace("Lua State iniciado");
	}

	/** Executa código Lua em string */
	public function runString(code:String):Void
	{
		var result = LuaL.dostring(state, code);

		if (result != 0)
			trace("Erro Lua: " + Lua.tostring(state, -1));
	}

	/** Executa arquivo Lua */
	public function runFile(path:String):Void
	{
		if (!sys.FileSystem.exists(path))
		{
			trace("Arquivo Lua não encontrado: " + path);
			return;
		}

		var result = LuaL.dofile(state, path);

		if (result != 0)
			trace("Erro Lua: " + Lua.tostring(state, -1));
	}

	/** Envia valor do Haxe para Lua */
	public function setGlobal(name:String, value:Dynamic):Void
	{
		Convert.toLua(state, value);
		Lua.setglobal(state, name);
	}

	/** Pega valor global do Lua */
	public function getGlobal(name:String):Dynamic
	{
		Lua.getglobal(state, name);
		return Convert.fromLua(state, -1);
	}
}
