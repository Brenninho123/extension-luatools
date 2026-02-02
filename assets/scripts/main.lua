-- =========================
-- LuaTools - Script Base
-- =========================

printHx("Iniciando script Lua...")
printHx("App: " .. getAppName())

-- =========================
-- Variáveis
-- =========================

version = "1.0.0"
author = "Brenninho123"

-- =========================
-- Funções Lua (Haxe chama)
-- =========================

function onInit()
	printHx("onInit() chamado pelo Haxe")
end

function onUpdate(dt)
	-- exemplo simples
	if dt then
		printHx("Update dt: " .. dt)
	end
end

function add(a, b)
	return sumHx(a, b)
end

function multiply(a, b)
	return a * b
end

-- =========================
-- Tabela estilo API
-- =========================

LuaTools = {
	name = getAppName(),
	version = version,

	info = function()
		printHx("LuaTools v" .. version .. " por " .. author)
	end
}

-- =========================
-- Execução inicial
-- =========================

LuaTools.info()
printHx("Soma (Lua -> Haxe): " .. add(10, 5))
printHx("Multiplicação (Lua puro): " .. multiply(4, 6))
printHx("Script Lua carregado com sucesso!")
