package;

import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;

/**
 * LuaTools - Entry Point
 * Projeto base para ferramentas/utilitários em Lua
 * Autor: Brenninho123
 */
class Main extends Sprite
{
	public function new()
	{
		super();

		// Espera o stage estar pronto
		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(?e:Event):Void
	{
		if (e != null)
			removeEventListener(Event.ADDED_TO_STAGE, init);

		trace("LuaTools iniciado com sucesso!");

		// Exemplo de chamada inicial
		start();
	}

	private function start():Void
	{
		// Aqui você pode inicializar:
		// - loaders
		// - ferramentas Lua
		// - sistema de comandos
		// - debug tools

		trace("Pronto para carregar ferramentas Lua.");
	}
}
