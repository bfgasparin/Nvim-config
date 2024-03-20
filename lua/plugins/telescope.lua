-- Fuzzy Finder (files, lsp, etc)
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        file_ignore_patterns = { "^public/" },
      },
    },
    config = function(plugin, opts)
      require("telescope").setup(opts)
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[F]ind existing [B]uffers' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<c-p>', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })

      -- Find file in vendor
      vim.keymap.set('n', '<leader>fv', function()
          builtin.find_files({
            no_ignore = true,
            search_dirs = { 'vendor' },
            prompt_title = 'Find Files in Vendor',
          })
      end, { desc = 'Find in [V]endors' })

      -- search in vendor dir
      vim.keymap.set('n', '<leader>f<Space>', function()
          builtin.live_grep({
            no_ignore = true,
            search_dirs = { 'vendor' },
            prompt_title = 'Live Grep in Vendors',
          })
      end, { desc = 'Find by Grep in [V]endors' })

      -- Search on all project
      vim.keymap.set('n', '<leader>fa', function()
        builtin.find_files(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
          prompt_title = 'Find Files in Project',
        })
      end, { desc = '[F]ind in [A]ll Project' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]find in [N]eovim files' })

      -- Search on current buffer
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      }

      -- load the extension in telescope
      require("telescope").load_extension("ui-select")
    end,
  }
}
