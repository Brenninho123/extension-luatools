package lua.sandbox;

class LuaSandboxManager {

	static var sandboxes:Map<String, LuaSandbox> = new Map();

	public static function create(id:String, scriptPath:String) {
		if (sandboxes.exists(id)) return;
		sandboxes.set(id, new LuaSandbox(id, scriptPath));
	}

	public static function remove(id:String) {
		if (!sandboxes.exists(id)) return;

		sandboxes.get(id).destroy();
		sandboxes.remove(id);
	}

	public static function get(id:String):LuaSandbox {
		return sandboxes.get(id);
	}

	public static function reload(id:String) {
		if (sandboxes.exists(id))
			sandboxes.get(id).reload();
	}

	public static function reloadAll() {
		for (s in sandboxes)
			s.reload();
	}

	public static function update(dt:Float) {
		for (s in sandboxes)
			s.call("onUpdate", [dt]);
	}
}