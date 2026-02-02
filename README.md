# extension-luatools

A powerful Lua integration toolkit for Haxe / OpenFL projects, featuring **sandboxed Lua**, **hot reload**, and an **engine-style API**.

Designed for tools, engines, mods, and scripting systems.

---

## ✨ Features

- 🔐 **Lua Sandbox**
  - Blocks dangerous libraries (`os`, `io`, `debug`, `package`)
  - Safe execution for mods and plugins

- ⚡ **Hot Reload**
  - Reload Lua scripts instantly when files change
  - No application restart required

- 🧠 **Engine-style API**
  - Clean `engine.*` namespace
  - No global pollution

- 🔁 **Lifecycle Callbacks**
  - `onInit()`
  - `onUpdate(dt)`
  - `onReload()`
  - `onShutdown()`

- 🔌 **Haxe ⇄ Lua Communication**
  - Call Lua functions from Haxe
  - Expose Haxe APIs to Lua safely

---

## 📦 Installation

Once published on Haxelib:

```bash
haxelib install extension-luatools