local status, telescope = pcall(require, "telescope")
if (not status) then return end

telescope.setup {
	defaults = {
		mappings = {
			n = {
				["q"] = require('telescope.actions').close
			},
		},
	},
}

telescope.load_extension("dap")

local nmap = require("setup.keymap").nmap
local builtin = require("telescope.builtin")
local ivy_theme = require("telescope.themes").get_ivy()
local merge_tables = require("setup.helpers").merge_tables

local normal_mode = merge_tables({
	sort_lastused = true,
	initial_mode = "normal",
}, ivy_theme)

require("setup.helpers").set_keymaps(nmap, {
	{ ';f',
		function()
			builtin.find_files(merge_tables({
				find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
			}, ivy_theme))
		end
	},
	{ ';g',
		function()
			builtin.live_grep(ivy_theme)
		end
	},
	{ '\\\\',
		function()
			builtin.buffers(merge_tables({
				sort_lastused = true,
			}, normal_mode))
		end
	},
	{ ';t',
		function()
			builtin.help_tags(ivy_theme)
		end
	},
	{ ';;',
		function()
			builtin.resume(ivy_theme)
		end
	},
	{ ';d',
		function()
			builtin.diagnostics(ivy_theme)
		end
	},
	{ ";b",
		function()
			telescope.extensions.file_browser.file_browser(merge_tables({
				path = "%:p:h",
				cwd = vim.fn.expand('%:p:h'),
				respect_gitignore = false,
				hidden = true,
				grouped = true,
				previewer = false,
				initial_mode = "normal",
				layout_config = { height = 40 }
			}, ivy_theme))
		end
	},
	{ ";h",
		function()
			telescope.extensions.harpoon.marks(normal_mode)
		end
	},
	{ ';db',
		function()
			telescope.extensions.dap.list_breakpoints(normal_mode)
		end
	},
	{ ';dc',
		function()
			telescope.extensions.dap.commands(normal_mode)
		end
	},
	{ ';dv',
		function()
			telescope.extensions.dap.variables(normal_mode)
		end
	},
	{ ';df',
		function()
			telescope.extensions.dap.frames(normal_mode)
		end
	},
	{ ';c',
		function()
			telescope.load_extension('neoclip').default(normal_mode)
		end
	}
})
