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


return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'


    use {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.pylsp.setup {}
            lspconfig.sqlls.setup {}
            lspconfig.clangd.setup {}
            lspconfig.ruby_ls.setup {}
            lspconfig.rust_analyzer.setup {}
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
        require"startup".setup()
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
