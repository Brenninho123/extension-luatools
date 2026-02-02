package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

import lua.sandbox.LuaSandboxManager;

class Main extends Sprite {

	var lastTime:Float = 0;

	public function new() {
		super();

		// Wait until added to stage
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}

	function onAdded(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);

		trace("Main initialized");

		// Create Lua sandboxes
		initLua();

		// Start update loop
		lastTime = Lib.getTimer();
		addEventListener(Event.ENTER_FRAME, update);
	}

	function initLua():Void {
		// Core script
		LuaSandboxManager.create(
			"core",
			"assets/scripts/main.lua"
		);

		// Example mod sandbox
		// LuaSandboxManager.create(
		//     "mod_example",
		//     "mods/example/main.lua"
		// );
	}

	function update(e:Event):Void {
		var now = Lib.getTimer();
		var dt:Float = (now - lastTime) / 1000;
		lastTime = now;

		// Update all Lua sandboxes
		LuaSandboxManager.update(dt);
	}

	public function reloadLua(id:String):Void {
		trace("Reloading Lua sandbox: " + id);
		LuaSandboxManager.reload(id);
	}

	public function reloadAllLua():Void {
		trace("Reloading all Lua sandboxes");
		LuaSandboxManager.reloadAll();
	}
}