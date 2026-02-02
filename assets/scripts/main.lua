-- =========================
-- LuaTools - Main Script
-- Hot Reload Ready
-- =========================

-- estado persistente (recriado a cada reload,
-- mas você pode salvar/recuperar se quiser)
LuaTools = LuaTools or {}

LuaTools.version = "1.1.0"
LuaTools.author  = "Brenninho123"
LuaTools.counter = LuaTools.counter or 0

-- =========================
-- INIT
-- =========================

function onInit()
	printHx("Lua iniciado")
	printHx("App: " .. getAppName())
	printHx("Versão LuaTools: " .. LuaTools.version)
end

-- =========================
-- UPDATE
-- =========================

function onUpdate(dt)
	LuaTools.counter = LuaTools.counter + dt

	-- exemplo: log a cada 2 segundos
	if LuaTools.counter >= 2 then
		printHx("Update rodando... dt acumulado = " .. LuaTools.counter)
		LuaTools.counter = 0
	end
end

-- =========================
-- HOT RELOAD
-- =========================

function onReload()
	printHx("♻ Hot Reload detectado!")
	printHx("Script Lua recarregado com sucesso")
end

-- =========================
-- SHUTDOWN (opcional)
-- =========================

function onShutdown()
	printHx("Lua finalizado")
end

-- =========================
-- FUNÇÕES CHAMÁVEIS PELO HAXE
-- =========================

function add(a, b)
	return sumHx(a, b)
end

function multiply(a, b)
	return a * b
end

function getInfo()
	return {
		name = getAppName(),
		version = LuaTools.version,
		author = LuaTools.author
	}
end

-- =========================
-- EXECUÇÃO INICIAL
-- =========================

printHx("main.lua carregado com sucesso!")