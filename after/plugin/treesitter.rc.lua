local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
	ensure_installed = {
		"lua",
		"tsx",
		"javascript",
		"typescript",
		"solidity",
		"svelte",
		"rust",
		"graphql"
	},
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	autotag = {
		enable = true,
	}
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "typescript.tsx" }
