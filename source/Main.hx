package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

import sys.FileSystem;

import lua.LuaManager;
import lua.LuaAPI;
import lua.EngineAPI;

class Main extends Sprite
{
	// Lua
	var lua:LuaManager;

	// Script
	final scriptPath:String = "assets/scripts/main.lua";
	var lastModified:Float = 0;

	// Timing
	var lastTime:Float = 0;

	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	/* ========================= */
	/* INIT                      */
	/* ========================= */

	function init(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		trace("🚀 LuaTools iniciando...");

		initLua();
		loadScript();

		lastModified = FileSystem.stat(scriptPath).mtime.getTime();
		lastTime = Lib.getTimer();

		addEventListener(Event.ENTER_FRAME, update);
	}

	function initLua():Void
	{
		lua = new LuaManager(scriptPath);

		// APIs básicas
		lua.exposeFunction("printHx", LuaAPI.print);
		lua.exposeFunction("sumHx", LuaAPI.sum);
		lua.exposeFunction("getAppName", LuaAPI.getAppName);

		// API engine.*
		lua.exposeFunction("engine_log", EngineAPI.log);
		lua.exposeFunction("engine_time", EngineAPI.getTime);
	}

	function loadScript():Void
	{
		lua.load();
		lua.call("onInit", []);
	}

	/* ========================= */
	/* UPDATE                    */
	/* ========================= */

	function update(e:Event):Void
	{
		checkHotReload();

		var now = Lib.getTimer();
		var dt:Float = (now - lastTime) / 1000;
		lastTime = now;

		lua.call("onUpdate", [dt]);
	}

	/* ========================= */
	/* HOT RELOAD                */
	/* ========================= */

	function checkHotReload():Void
	{
		var current = FileSystem.stat(scriptPath).mtime.getTime();

		if (current != lastModified)
		{
			lastModified = current;

			trace("♻ Hot Reload detectado");
			lua.reload();
			lua.call("onInit", []);
		}
	}

	/* ========================= */
	/* SHUTDOWN                  */
	/* ========================= */

	public function shutdown():Void
	{
		trace("🛑 Encerrando LuaTools...");
		removeEventListener(Event.ENTER_FRAME, update);
		lua.call("onShutdown", []);
	}
}