return {
	{ -- Main LSP Configuration
		'neovim/nvim-lspconfig',
		event = { 'VeryLazy' },
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{ 'williamboman/mason.nvim', opts = {} },
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			-- Useful status updates for LSP.
			{ 'j-hui/fidget.nvim',       opts = {} },
			'saghen/blink.cmp', -- completion
			{
				'akinsho/flutter-tools.nvim',
				dependencies = { 'nvim-lua/plenary.nvim' },
				config = true,
			}, -- flutter support
			-- 'dart-lang/dart-vim-plugin',
			-- 'Nash0x7E2/awesome-flutter-snippets'
		},
		opts = {
			servers = {
				-- clangd = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See :help lspconfig-all for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				-- But for many setups, the LSP (ts_ls) will work just fine
				ts_ls = {},
				-- eslint = {}, -- could load eslint here instead of in nvim-lint
				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
							diagnostics = {
								globals = { 'vim' }, -- Recognize the global vim variable
							}
							-- You can toggle below to ignore Lua_LS's noisy missing-fields warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}
		},
		config = function(_, opts)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
				callback = function(event)
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func,
							{ buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- keymaps are in snacks.lua since the picker is part of snacks

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has 'nvim-0.11' == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						local highlight_augroup = vim.api.nvim_create_augroup(
							'kickstart-lsp-highlight', { clear = false })
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd('LspDetach', {
							group = vim.api.nvim_create_augroup('kickstart-lsp-detach',
								{ clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
						map('<leader>th', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
						end, '[T]oggle Inlay [H]ints')
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config {
				severity_sort = true,
				float = { border = 'rounded', source = 'if_many' },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					},
				} or {},
				virtual_text = {
					source = 'if_many',
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			}

			-- Ensure the servers and tools are installed
			-- mason had to be setup earlier: to configure its options see the
			-- You can add other tools here that you want Mason to install for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(opts.servers or {})
			vim.list_extend(ensure_installed, {
				'stylua', -- Used to format Lua code
				'eslint_d',
				'ts_ls'
			})
			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

		require('mason-lspconfig').setup {
			ensure_installed = vim.tbl_keys(opts.servers or {}),
			automatic_installation = false,
			handlers = {
				function(server)
					local lspconfig = require('lspconfig')
					local config = opts.servers[server] or {}
					config.capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
					
					-- Use the default lspconfig setup for this server
					if lspconfig[server] then
						lspconfig[server].setup(config)
					end
				end,
			}
		}

			-- setup flutter-tools defaults
			-- don't manually configure dartls with lsp-config or nvim-dap since flutter-tools does that
			-- if flutter isn't installed in $PATH, need to do some more configuring
			require('flutter-tools').setup {
				debugger = {
					enabled = true,
				}
			}
		end,
	},
	{ -- Linting
		'mfussenegger/nvim-lint',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local lint = require 'lint'
			lint.linters_by_ft = {
				markdown = { 'markdownlint' },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "pylint" },
			}

			-- To allow other plugins to add linters to require('lint').linters_by_ft,
			-- instead set linters_by_ft like this:
			-- lint.linters_by_ft = lint.linters_by_ft or {}
			-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
			--
			-- However, note that this will enable a set of default linters,
			-- which will cause errors unless these tools are available:
			-- {
			--   clojure = { "clj-kondo" },
			--   dockerfile = { "hadolint" },
			--   json = { "jsonlint" },
			--   markdown = { "vale" },
			--   rst = { "vale" },
			-- }
			--
			-- You can disable the default linters by setting their filetypes to nil:
			-- lint.linters_by_ft['clojure'] = nil
			-- lint.linters_by_ft['dockerfile'] = nil
			-- lint.linters_by_ft['inko'] = nil

			-- Set pylint to work in virtualenv
			lint.linters.pylint.cmd = 'python3'
			lint.linters.pylint.args = { '-m', 'pylint', '-f', 'json' }
			--
			-- local python_cmd = 'python'
			-- if vim.env.VIRTUAL_ENV then
			-- 	python_cmd = vim.env.VIRTUAL_ENV .. '/bin/python'
			-- end
			-- lint.linters.pylint.cmd = python_cmd
			-- lint.linters.pylint.args = { '-m', 'pylint', '-f', 'json' }

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
			vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' },
				{ -- TextChanged and InsertLeave might be too aggressive for some linters
					group = lint_augroup,
					callback = function()
						-- Only run the linter in buffers that you can modify in order to
						-- avoid superfluous noise, notably within the handy LSP pop-ups that
						-- describe the hovered symbol using Markdown.
						if vim.opt_local.modifiable:get() then
							lint.try_lint()
						end
					end,
				})
			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
	{ -- Autoformat
		'stevearc/conform.nvim',
		event = { 'BufWritePre' },
		cmd = { 'ConformInfo' },
		keys = {
			{
				'<leader>f',
				function()
					require('conform').format { async = true, lsp_format = 'fallback' }
				end,
				mode = '',
				desc = '[F]ormat buffer',
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- A table of filetypes to DISABLE format-on-save for
				local disable_on_save = {
					typescriptreact = true, -- This will disable formatting for .tsx files
					-- typescript = true,   -- You can uncomment this to also disable for .ts files
				}

				-- If the filetype is in our disable list, return nil to skip formatting
				if disable_on_save[vim.bo[bufnr].filetype] then
					return nil
				end

				-- For all other filetypes, proceed with formatting
				return {
					timeout_ms = 500,
					lsp_format = 'fallback', -- Or 'never' if you prefer
				}
			end,
			formatters_by_ft = {
				lua = { 'stylua' },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				-- It's also good practice to include other common web formats if you use Prettier for them:
				json = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				less = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
}
