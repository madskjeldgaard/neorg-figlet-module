# A Figlet module for Neorg

This is a small plugin / module for [Neorg](https://github.com/nvim-neorg/neorg), making it possible to easily insert figlet text in a document.

## Installation

Install using packer:

```lua
use "madskjeldgaard/neorg-figlet-module"

```

## Configuration

In the `load` section of your neorg module, as a minimum add `["external.integrations.figlet"] = {}`, and fill out the config options:

```lua
require('neorg').setup({
	load = {
		["external.integrations.figlet"] = {
			config = {
				font = "doom",
				wrapInCodeTags = true
			}
		},
		["core.defaults"] = {}, -- Loads default behaviour
...
    })
```

This will expose a keymap to the `keymap` part of your neorg setup. Use it like this:

```lua
-- Prompt for text and insert as figletized
keybinds.map("norg", "n", "<leader>ff",
    "<cmd>Neorg keybind norg external.integrations.figlet.figletize<cr>")
```
