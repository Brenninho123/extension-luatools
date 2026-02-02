package lua.sandbox;

import llua.Lua;
import llua.LuaL;
import llua.State;
import lua.EngineAPI;

class LuaSandbox {
	public var id:String;
	public var state:State;
	public var scriptPath:String;
	public var enabled:Bool = true;

	public function new(id:String, scriptPath:String) {
		this.id = id;
		this.scriptPath = scriptPath;
		create();
	}

	function create() {
		state = LuaL.newstate();
		LuaL.openlibs(state);

		// Sandbox security
		blockGlobals();

		// Register engine API
		EngineAPI.register(state, id);

		load();
	}

	public function load() {
		try {
			LuaL.dofile(state, scriptPath);
			call("onInit");
		} catch (e) {
			trace('[LuaSandbox:$id] Load error: $e');
		}
	}

	public function reload() {
		destroy();
		create();
		call("onReload");
	}

	public function call(func:String, ?args:Array<Dynamic>) {
		if (!enabled || state == null) return;

		Lua.getglobal(state, func);
		if (!Lua.isfunction(state, -1)) {
			Lua.pop(state, 1);
			return;
		}

		if (args != null)
			for (a in args)
				Lua.pushdynamic(state, a);

		var result = Lua.pcall(state, args != null ? args.length : 0, 0, 0);
		if (result != 0) {
			trace('[LuaSandbox:$id] Runtime error: ' + Lua.tostring(state, -1));
			Lua.pop(state, 1);
		}
	}

	public function destroy() {
		if (state == null) return;
		call("onShutdown");
		Lua.close(state);
		state = null;
	}

	function blockGlobals() {
		var blocked = [
			"os",
			"io",
			"debug",
			"package",
			"require",
			"dofile",
			"loadfile"
		];

		for (g in blocked) {
			Lua.pushnil(state);
			Lua.setglobal(state, g);
		}
	}
}
