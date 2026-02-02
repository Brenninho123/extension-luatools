package;

import openfl.display.Sprite;
import openfl.events.Event;
import lua.LuaManager;

class Main extends Sprite
{
	var lua:LuaManager;

	public function new()
	{
		super();

		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	function init(?e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		lua = new LuaManager();

		// Exemplo: variável do Haxe indo pro Lua
		lua.setGlobal("appName", "LuaTools");

		// Executa código direto
		lua.runString('
			print("Hello from Lua!")
			print("App:", appName)
		');

		// Executa arquivo
		lua.runFile("assets/scripts/test.lua");
	}
}