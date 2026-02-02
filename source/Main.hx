package;

import openfl.display.Sprite;
import openfl.events.Event;
import lua.LuaManager;
import lua.LuaAPI;

class Main extends Sprite
{
	var lua:LuaManager;

	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	function init(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		lua = new LuaManager();

		// Expor APIs
		lua.exposeFunction("printHx", LuaAPI.print);
		lua.exposeFunction("sumHx", LuaAPI.sum);
		lua.exposeFunction("getAppName", LuaAPI.getAppName);

		// Executar Lua
		lua.runString('
			printHx("Lua conectado!")
			printHx("App: " .. getAppName())
			printHx("Soma: " .. sumHx(5, 3))
		');

		// Chamar função Lua
		lua.runString('
			function multiply(a, b)
				return a * b
			end
		');

		var result = lua.call("multiply", [4, 6]);
		trace("Resultado Lua -> Haxe: " + result);
	}
}