package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

import lua.LuaManager;
import lua.LuaAPI;

class Main extends Sprite
{
	// Core
	var lua:LuaManager;

	// Timing
	var lastTime:Float = 0;

	public function new()
	{
		super();

		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	/* ========================= */
	/* INIT                      */
	/* ========================= */

	function init(?e:Event):Void
	{
		if (e != null)
			removeEventListener(Event.ADDED_TO_STAGE, init);

		trace("Inicializando LuaTools...");

		initLua();
		loadScripts();

		lastTime = Lib.getTimer();
		addEventListener(Event.ENTER_FRAME, update);

		trace("LuaTools iniciado com sucesso!");
	}

	/* ========================= */
	/* LUA                       */
	/* ========================= */

	function initLua():Void
	{
		lua = new LuaManager();

		// Expor APIs Haxe -> Lua
		lua.exposeFunction("printHx", LuaAPI.print);
		lua.exposeFunction("sumHx", LuaAPI.sum);
		lua.exposeFunction("getAppName", LuaAPI.getAppName);
	}

	function loadScripts():Void
	{
		// Script principal
		lua.runFile("assets/scripts/main.lua");

		// Chama init do Lua se existir
		lua.call("onInit", []);
	}

	/* ========================= */
	/* UPDATE                    */
	/* ========================= */

	function update(e:Event):Void
	{
		var currentTime = Lib.getTimer();
		var dt:Float = (currentTime - lastTime) / 1000;
		lastTime = currentTime;

		// Chama update do Lua
		lua.call("onUpdate", [dt]);
	}

	/* ========================= */
	/* SHUTDOWN                  */
	/* ========================= */

	public function shutdown():Void
	{
		trace("Finalizando LuaTools...");

		removeEventListener(Event.ENTER_FRAME, update);
		lua.call("onShutdown", []);
	}
}