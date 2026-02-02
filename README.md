# extension-luatools

A modern **Lua integration toolkit for Haxe**, focused on **sandboxed execution**, **hot reload**, and a clean **engine-style API**.

Built for game engines, tools, modding systems, and extensible applications.

---

## ✨ Features

- 🔐 **Secure Lua Sandbox**
  - Dangerous libraries are disabled (`os`, `io`, `debug`, `package`)
  - Safe to run user scripts and mods

- ⚡ **Lua Hot Reload**
  - Reload Lua scripts at runtime
  - No application restart required

- 🧠 **Engine-style API**
  - APIs exposed under a single `engine` namespace
  - No global pollution

- 🔁 **Lifecycle Callbacks**
  - `onInit()`
  - `onUpdate(dt)`
  - `onReload()`
  - `onShutdown()`

- 🔌 **Haxe ⇄ Lua Bridge**
  - Call Lua functions from Haxe
  - Expose Haxe functions and data to Lua safely

---

## 📦 Installation

### From Haxelib

```bash
haxelib install extension-luatools