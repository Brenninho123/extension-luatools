LuaTools = LuaTools or {}

LuaTools.info = {
	name    = getAppName(),
	version = "1.2.0",
	author  = "Brenninho123"
}

LuaTools.time = LuaTools.time or 0
LuaTools.ticks = LuaTools.ticks or 0


function onInit()
	engine_log("Lua iniciado")
	engine_log("App: " .. LuaTools.info.name)
	engine_log("Versão: " .. LuaTools.info.version)
end

function onUpdate(dt)
	LuaTools.time = LuaTools.time + dt
	LuaTools.ticks = LuaTools.ticks + 1

	-- log a cada 1 segundo
	if LuaTools.time >= 1 then
		engine_log("Tick: " .. LuaTools.ticks)
		LuaTools.time = 0
	end
end

-- =================================
-- HOT RELOAD
-- =================================

function onReload()
	engine_log("🔥 Script Lua recarregado (hot reload)")
end

-- =================================
-- SHUTDOWN
-- =================================

function onShutdown()
	engine_log("Lua finalizado com segurança")
end

-- =================================
-- FUNÇÕES PARA HAXE
-- =================================

function add(a, b)
	return sumHx(a, b)
end

function multiply(a, b)
	return a * b
end

function getInfo()
	return LuaTools.info
end

-- =================================
-- BOOT
-- =================================

printHx("main.lua carregado com sucesso!")