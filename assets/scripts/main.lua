-- =====================================
-- LuaTools - Main Script
-- Engine API + Sandbox + Hot Reload
-- =====================================

-- Namespace principal
LuaTools = LuaTools or {}

LuaTools.state = {
	time = LuaTools.state and LuaTools.state.time or 0,
	ticks = LuaTools.state and LuaTools.state.ticks or 0
}

LuaTools.info = {
	name    = engine.app.name,
	version = engine.app.version,
	author  = "Brenninho123"
}

-- =====================================
-- INIT
-- =====================================

function onInit()
	engine.log("Lua iniciado")
	engine.log("App: " .. LuaTools.info.name)
	engine.log("Versão: " .. LuaTools.info.version)
end

-- =====================================
-- UPDATE
-- =====================================

function onUpdate(dt)
	LuaTools.state.time  = LuaTools.state.time + dt
	LuaTools.state.ticks = LuaTools.state.ticks + 1

	-- Log a cada 1 segundo
	if LuaTools.state.time >= 1 then
		engine.log("Ticks: " .. LuaTools.state.ticks)
		LuaTools.state.time = 0
	end
end

-- =====================================
-- HOT RELOAD
-- =====================================

function onReload()
	engine.log("♻ Hot Reload aplicado com sucesso")
end

-- =====================================
-- SHUTDOWN
-- =====================================

function onShutdown()
	engine.log("Lua encerrado")
end

-- =====================================
-- FUNÇÕES PARA HAXE
-- =====================================

function add(a, b)
	return a + b
end

function multiply(a, b)
	return a * b
end

function getInfo()
	return LuaTools.info
end

-- =====================================
-- TESTES DE API
-- =====================================

engine.log("Tempo atual: " .. engine.time())
engine.log("Número aleatório: " .. engine.random(1, 100))

engine.log("main.lua carregado com sucesso ✅")