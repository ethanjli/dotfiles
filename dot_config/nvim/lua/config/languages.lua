-- Treesitter

require("nvim-treesitter.configs").setup({
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

-- Mason

require("mason").setup()
require("mason-lspconfig").setup({
	-- note: automatic_installation doesn't seem to work, so we manually add LSPs to ensure_installed
	ensure_installed = {
		-- refer to https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
		"typos_lsp",
		"marksman",
		"texlab",
		"gopls",
		"golangci_lint_ls",
		"rust_analyzer",
		"ruff",
		"sqlls",
		"regols",
		"ts_ls",
		"biome",
		"stimulus_ls",
		"svelte",
		"html",
		"htmx",
		"cssls",
		"stylelint_lsp",
		"somesass_ls",
		"tailwindcss",
		"dockerls",
		"docker_compose_language_service",
		"terraformls",
		"tflint",
		"bashls",
		"lua_ls",
		"autotools_ls",
		"yamlls",
		"taplo",
	},
	automatic_installation = true,
})

-- Language servers

local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", {})

	-- Mappings:
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, {
			buffer = bufnr,
			noremap = true,
			silent = true,
			desc = "LSP: " .. desc,
		})
	end
	map("gD", vim.lsp.buf.declaration, "Goto symbol declaration")
	map("gd", vim.lsp.buf.definition, "Goto symbol definition")
	map("<leader>r", vim.lsp.buf.references, "Show all references")
	map("<Enter>", vim.lsp.buf.hover, "Symbol summary")
	map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
	map("<leader>ca", vim.lsp.buf.rename, "Execute code action on symbol")
	map("<leader>e", vim.diagnostic.open_float, "Show diagnostic message")
	map("[d", vim.diagnostic.goto_prev, "Previous diagnostic message")
	map("]d", vim.diagnostic.goto_next, "Next diagnostic message")
	map("<leader>q", vim.diagnostic.setloclist, "Show all diagnostics")
end
local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_cmds,
	desc = "global on_attach",
	callback = function(event)
		local bufnr = event.buf
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		on_attach(client, bufnr)
	end,
})

-- prose
vim.lsp.enable("typos_lsp")

-- Markdown
vim.lsp.enable("marksman")

-- LaTeX
vim.lsp.config("texlab", {
	settings = {
		build = {
			executable = "tectonic",
			args = {
				"-X",
				"compile",
				"%f",
				"--synctex",
				"--keep-logs",
				"--keep-intermediates",
			},
		},
	},
})
vim.lsp.enable("texlab")

-- Go
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
})
vim.lsp.enable("gopls")
vim.lsp.config("golangci_lint_ls", {
	root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
	init_options = {
		command = {
			"golangci-lint",
			"run",
			"--output.json.path",
			"stdout",
			"--show-stats=false",
			"--issues-exit-code=1",
		},
	},
	filetypes = { "go", "gomod" },
})
vim.lsp.enable("golangci_lint_ls")

-- Rust
vim.lsp.enable("rust_analyzer")

-- Python
vim.lsp.enable("ruff")

-- SQL
vim.lsp.enable("sqlls")

-- Rego
vim.lsp.enable("regols")

-- JavaScript/TypeScript
vim.lsp.enable("ts_ls")
vim.lsp.config("biome", {
	single_file_support = true,
})
vim.lsp.enable("biome")
vim.lsp.enable("stimulus_ls")
vim.lsp.enable("svelte")

-- HTML
vim.lsp.enable("html")
vim.lsp.enable("htmx")

-- CSS
vim.lsp.enable("cssls")
vim.lsp.enable("stylelint_lsp")
vim.lsp.enable("somesass_ls")
vim.lsp.enable("tailwindcss")

-- Docker
vim.lsp.enable("dockerls")
vim.lsp.enable("docker_compose_language_service")

-- Terraform
vim.lsp.enable("terraformls")
vim.lsp.enable("tflint")

-- bash
vim.lsp.enable("bashls")

-- Lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {},
	},
	on_init = function(client)
		if client.workspace_folders == nil then
			return
		end
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					"${3rd}/luv/library", -- see https://github.com/folke/lazy.nvim/discussions/1349
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
})
vim.lsp.enable("lua_ls")

-- Make/etc.
vim.lsp.enable("autotools_ls")

-- JSON/YAML/TOML/etc.
vim.lsp.enable("yamlls")
vim.lsp.enable("taplo")

-- Linters

local mti = require("mason-tool-installer")
mti.setup({
	ensure_installed = {
		"djlint",
	},
})

-- Formatters

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		-- ["*"] = { "typos" },
		markdown = { "markdownfmt", "mdsf" },
		go = { "goimports", "gofumpt", "golines" },
		rust = { "rustfmt" },
		python = { "ruff_format", "ruff_fix" },
		sql = { "sqlfmt" },
		rego = { "opa_fmt" },
		javascript = { "biome", "biome-check" },
		typescript = { "biome", "biome-check" },
		html = { "biome", "biome-check" },
		css = { "biome", "biome-check" },
		tf = { "tofu_fmt" },
		terraform = { "tofu_fmt" },
		sh = { "shfmt", "shellharden" },
		bash = { "shfmt", "shellharden" },
		lua = { "stylua" },
		yaml = { "yamlfmt", "yq" },
		json = { "jq" },
		toml = { "taplo" },
		hcl = { "hcl" },
		kdl = { "kdlfmt" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	notify_on_error = true,
	notify_no_formatters = true,
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
conform.setup({
	format_on_save = function(bufnr)
		-- Disable autoformat on certain filetypes
		local ignore_filetypes = {
			"yaml",
			"json",
		}
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

-- Go
conform.formatters.golines = {
	prepend_args = { "-m", "100", "-t", "2" },
}

-- bash
conform.formatters.shfmt = {
	prepend_args = { "-i", "2" },
}

-- Mason-Conform
require("mason-conform").setup()
