package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

import sys.FileSystem;
import sys.io.File;

import lua.LuaManager;
import lua.LuaAPI;

class Main extends Sprite
{
	var lua:LuaManager;

	var scriptPath = "assets/scripts/main.lua";
	var lastModified:Float = 0;

	var lastTime:Float = 0;

	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	function init(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		initLua();

		lastModified = FileSystem.stat(scriptPath).mtime.getTime();

		lastTime = Lib.getTimer();
		addEventListener(Event.ENTER_FRAME, update);
	}

	function initLua():Void
	{
		lua = new LuaManager(scriptPath);

		// Expor APIs
		lua.exposeFunction("printHx", LuaAPI.print);
		lua.exposeFunction("sumHx", LuaAPI.sum);
		lua.exposeFunction("getAppName", LuaAPI.getAppName);

		lua.load();
		lua.call("onInit", []);
	}

	function update(e:Event):Void
	{
		checkHotReload();

		var now = Lib.getTimer();
		var dt = (now - lastTime) / 1000;
		lastTime = now;

		lua.call("onUpdate", [dt]);
	}

	function checkHotReload():Void
	{
		var current = FileSystem.stat(scriptPath).mtime.getTime();

		if (current != lastModified)
		{
			lastModified = current;

			lua.reload();
			lua.call("onInit", []);
		}
	}
}