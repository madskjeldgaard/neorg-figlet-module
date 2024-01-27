local neorg = require('neorg.core')

local module = neorg.modules.create('external.integrations.figlet')

module.setup = function()
	return {
		success = true,
		requires = { "core.neorgcmd", "core.keybinds", "core.ui" },
	}
end

module.figletize_text = function(text, font, wrapInCodeTags)
	-- Call command
	local figletText = vim.fn.systemlist("figlet -f " ..
		font .. " " .. text)

	-- Place text here
	local lines = {}

	if wrapInCodeTags then
		-- Add code tag to table
		table.insert(lines, "@code")
	end

	-- Add Figlet text
	for _, line in ipairs(figletText) do
		table.insert(lines, line)
		print(line)
	end

	if wrapInCodeTags then
		-- Add code tag to table
		table.insert(lines, "@end")
	end

	-- Insert into file at cursor
	vim.api.nvim_put(lines, "", true, true)
end


module.load = function()
	module.required["core.keybinds"].register_keybind(module.name, "figletize")
end

module.on_event = function(event)
	if event.type == "core.keybinds.events.external.integrations.figlet.figletize" then
		local buffer = event.buffer
		local font = module.config.public.font or "poison"
		local wrapInCodeTags = module.config.public.wrapInCodeTags or true

		module.required["core.ui"].create_prompt("NeorgFigletize", "Figletize: ", function(text)
			-- Close popup
			vim.cmd("q")

			-- Run figletizer and insert text
			module.figletize_text(text, font, wrapInCodeTags)
		end, {
			center_x = true,
			center_y = true,
		}, {
			width = 25,
			height = 1,
			row = 10,
			col = 0,
		})
	end
end

module.events.subscribed = {
	["core.keybinds"] = {
		["external.integrations.figlet.figletize"] = true,
	},
}

return module
