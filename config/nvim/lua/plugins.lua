local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])



function setup_nvim_cmp()
    local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-p>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]--

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
end


return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.code_action() end, bufopts)
    vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.declaration() end, bufopts)

    use {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            local configs = require("lspconfig.configs")
            local util = require("lspconfig.util")


            setup_nvim_cmp()

            -- Configuation for lsp_cmpl
            --lspconfig.sorbet.setup{
                --on_attach=on_attach,
                --init_options = {
                    --highlightUntyped = true,
                --},
            --}
            --on_attach = function(client, bufnr)
                --client.server_capabilities.completionProvider.triggerCharacters = {}
                --require'lsp_compl'.attach(client, bufnr, { server_side_fuzzy_completion = true })
            --end

            configs.ruby_lsp = {
                default_config = {
                    cmd = { "bundle", "exec", "ruby-lsp" },
                    filetypes = { "ruby" },
                    root_dir = util.root_pattern("Gemfile", ".git"),
                    init_options = {
                        enabledFeatures = {
                            "documentHighlights",
                            "documentSymbols",
                            "foldingRanges",
                            "selectionRanges",
                            -- "semanticHighlighting",
                            "formatting",
                            "codeActions",
                        },
                    },
                    settings = {},
                },
            }

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- lspconfig.ruby_lsp.setup {}
            lspconfig.clangd.setup {}
            lspconfig.pylsp.setup {}
            lspconfig.rust_analyzer.setup {}
            lspconfig.sorbet.setup{
                capabilities = capabilities,
                init_options = {
                    highlightUntyped = false,
                },
            }
            lspconfig.sqlls.setup {}
        end
    }


    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
        config = function()
            require("nvim-navic").setup {
                lsp = { auto_attach = true, preference = {'clangd'} }
            }
        end
    }

    use {"nvim-tree/nvim-web-devicons"}

    use {
      "utilyre/barbecue.nvim",
      tag = "*",
      requires = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
      },
      after = "nvim-web-devicons",
      config = function()
        require("barbecue").setup()
      end
    }

    use {
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup()
      end
    }

    use {
      "startup-nvim/startup.nvim",
      requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
      config = function()
        require("startup").setup(require("startup-theme"))
        vim.api.nvim_create_autocmd("FileType", {
            pattern={"startup"},
            callback=function()
                    vim.cmd "DisableWhitespace"
                    vim.o.colorcolumn = 0
                end
            })
      end
    }

end)
