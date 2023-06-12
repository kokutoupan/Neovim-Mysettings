return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
      vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', {})
      vim.api.nvim_set_keymap('v', '<C-_>', 'gc', {})
    end
  },
  {
    'nvim-tree/nvim-web-devicons',
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        cterm_color = "65",
        name = "Zsh"
      }
    };
    -- globally enable different highlight colors per icon (default to true)
    -- if set to false all icons will have the default icon's color
    color_icons = true;
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
    -- globally enable "strict" selection of icons - icon will be looked up in
    -- different tables, first by filename, and if not found by extension; this
    -- prevents cases when file doesn't have any extension but still gets some icon
    -- because its name happened to match some extension (default to false)
    strict = true;
    -- same as `override` but specifically for overrides by filename
    -- takes effect when `strict` is true
    override_by_filename = {
      [".gitignore"] = {
        icon = "",
        color = "#f1502f",
        name = "Gitignore"
      }
    };
    -- same as `override` but specifically for overrides by extension
    -- takes effect when `strict` is true
    override_by_extension = {
      ["log"] = {
        icon = "",
        color = "#81e043",
        name = "Log"
      }
    };
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
      -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
    end,
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
        vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {silent = true})
      })
    end
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        background_colour = "#000000",
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
      vim.api.nvim_set_keymap("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true, silent = true})
    end,
    dependencies = {"kkharji/sqlite.lua"}
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup{}
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    "williamboman/mason.nvim",
    event = "BufReadPre",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
    config = function()
      local nvim_lsp = require('lspconfig')
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local opts = {}
          nvim_lsp[server_name].setup(opts)
        end
      })
      require("mason-lspconfig").setup()
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
    }
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline"
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end
        },

        window = {
          completion = cmp.config.window.bordered({
            border = 'single'
          }),
          documentation = cmp.config.window.bordered({
            border = 'single'
          }),
        },

        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          -- { name = 'calc' },
        }, {
          { name = 'buffer', keyword_length = 2 },
        })
      })


      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline', keyword_length = 2 }
        })
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.cmd('let g:vsnip_filetypes = {}')
    end,
  }
}
