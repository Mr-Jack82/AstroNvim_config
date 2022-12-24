--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  ["nvim-autopairs"] = {
    add_rules = function()
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"

      --- BRACKET PAIR SPACING ---
      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      local rules = {
        -- Put space between brackets from both ends
        Rule(" ", " ")
            :with_pair(function(opts)
              local pair = opts.line:sub(opts.col - 1, opts.col)
              return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
              }, pair)
            end)
            :with_move(cond.none())
            :with_cr(cond.none())
            :with_del(function(opts)
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local context = opts.line:sub(col - 1, col + 2)
              return vim.tbl_contains({
                brackets[1][1] .. "  " .. brackets[1][2],
                brackets[2][1] .. "  " .. brackets[2][2],
                brackets[3][1] .. "  " .. brackets[3][2],
              }, context)
            end),
      }
      -- Jump outside spaced bracket with corresponding closing bracket key
      for _, bracket in pairs(brackets) do
        table.insert(
          rules,
          Rule("", " " .. bracket[2])
          :with_pair(cond.none())
          :with_move(function(opts) return opts.char == bracket[2] end)
          :with_cr(cond.none())
          :with_del(cond.none())
          :use_key(bracket[2])
        )
      end
      return rules
    end,
  },
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme to use
  colorscheme = "default_theme",

  -- Add highlight groups in any theme
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    -- }
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      -- set to true or false etc.
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "yes:1",
      wrap = false, -- sets vim.opt.wrap
      textwidth = 80,
      colorcolumn = "81",
      tabstop = 2,
      smartindent = true,
      shiftwidth = 2,
      softtabstop = 2,
    },
    g = {
      mapleader = ",", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
    " █████  ███████ ████████ ██████   ██████",
    "██   ██ ██         ██    ██   ██ ██    ██",
    "███████ ███████    ██    ██████  ██    ██",
    "██   ██      ██    ██    ██   ██ ██    ██",
    "██   ██ ███████    ██    ██   ██  ██████",
    " ",
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  },

  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        disable_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- Configure plugins
  plugins = {
    heirline = function(config)
      -- the first element of the default configuration table is the statusline
      config[1] = {
        -- set the fg/bg of the statusline
        hl = { fg = "fg", bg = "bg" },
        -- when adding the mode component, enable the mode text with padding to the left/right of it
        astronvim.status.component.mode { mode_text = { padding = { left = 1, right = 1 } } },
        -- add all the other components for the statusline
        astronvim.status.component.git_branch(),
        astronvim.status.component.file_info(),
        astronvim.status.component.git_diff(),
        astronvim.status.component.diagnostics(),
        astronvim.status.component.fill(),
        astronvim.status.component.macro_recording(),
        astronvim.status.component.fill(),
        astronvim.status.component.lsp(),
        astronvim.status.component.treesitter(),
        astronvim.status.component.nav(),
      }
      -- return the final configuration table
      return config
    end,
    ["neo-tree"] = {
      window = {
        width = 28,
        mappings = {
          ["l"] = "open",
        },
      },
    },
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },
      ["max397574/better-escape.nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- Add plugins, the packer syntax without the "use"
      ["phaazon/hop.nvim"] = {
        branch = "v2",
        config = function()
          require("hop").setup {
            uppercase_labels = true,
            keys = "etovxqpdygfblzhckisuran",
          }
        end,
      },

      -- Surrounding everything with brackets etc.
      ["tpope/vim-surround"] = {},

      -- A Git wrapper so awesome it should be illegal
      ["tpope/vim-fugitive"] = {
        requires = {
          "tpope/vim-rhubarb",
        },
        cmd = {
          "Git",
          "Gdiff",
          "Gdiffsplit",
          "Gwrite",
          "Gw",
        },
      },

      -- The **Dot** command all mighty
      ["tpope/vim-repeat"] = {},

      -- Pairs of handy bracket mappings
      ["tpope/vim-unimpaired"] = {
        keys = { "[", "]" },
      },

      -- A Vim aligment plugin
      ["junegunn/vim-easy-align"] = {},

      -- Easy text exchange operator for Vim
      ["tommcdo/vim-exchange"] = {},

      -- A Vim plugin which saves files to disk automatically
      ["907th/vim-auto-save"] = {},

      -- Seamless navigation between tmux panes and vim splits
      ["christoomey/vim-tmux-navigator"] = {},

      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },

      -- We also support a key value style plugin definition similar to NvChad:
      -- ["ray-x/lsp_signature.nvim"] = {
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      -- local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
      }
      return config -- return final config table
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      ensure_installed = {
        "help",
        "c",
        "lua",
        "bash",
        "vim",
        "toml",
        "markdown",
        "javascript",
        "typescript",
        "css",
        "vue",
        "html",
      },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      -- ensure_installed = { "sumneko_lua" },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      -- ensure_installed = { "prettier", "stylua" },
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set key binding
    local map = vim.keymap.set

    -- Hop key bindings
    local hop = require "hop"
    local directions = require("hop.hint").HintDirection

    map("n", "s", "<cmd>HopChar1<CR>", { noremap = false, silent = false })
    map("", "<leader>/", "<cmd>HopPattern<CR>")
    map(
      "",
      "f",
      function() hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true } end,
      { remap = true }
    )
    map(
      "",
      "F",
      function() hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true } end,
      { remap = true }
    )
    map(
      "",
      "t",
      function() hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 } end,
      { remap = true }
    )
    map(
      "",
      "T",
      function() hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 } end,
      { remap = true }
    )
    map("o", "z", "<cmd>lua require'hop'.hint_char1()<CR>", { noremap = true })

    -- Some other mappings
    vim.cmd [[command! PU PackerUpdate]]
    vim.cmd [[command! -nargs=* Wrap set wrap linebreak nolist]]
    vim.cmd [[cabbrev w!! execute 'silent write !sudo tee % >/dev/null' <bar> edit!]]

    -- Select last pasted text
    map("n", "gV", "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true })

    map("n", "J", "mzJ`z")
    map("n", "n", "nzzzv")
    map("n", "N", "Nzzzv")

    map("x", "<leader>p", [["_dP]])

    -- Move text around
    map("v", "J", ":m '>+1<CR>gv=gv")
    map("v", "K", ":m '<-2<CR>gv=gv")

    -- Remap for dealing with word wrap
    map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

    -- Make {motion} text uppercase in INSERT mode.
    map("!", "<C-f>", "<Esc>gUiw`]a", { noremap = false })

    -- easy expansion of the active file directory
    map("c", "%%", "<C-r>=fnameescape(expand('%:h')).'/'<CR>", { silent = false })
    map("", "<leader>ew", ":e %%", { noremap = false, silent = false })
    map("", "<leader>es", ":sp %%", { noremap = false, silent = false })
    map("", "<leader>ev", ":vsp %%", { noremap = false, silent = false })
    map("", "<leader>et", ":tabe %%", { noremap = false, silent = false })

    -- Set working directory to the current buffer's directory
    map("n", "cd", ":lcd %:p:h<bar>lua print('current directory is ' .. vim.fn.getcwd())<CR>", { silent = false })
    map("n", "cu", "..<bar>pwd<CR>", { silent = false })

    -- Moving left/right in *INSERT* mode
    map("i", "<C-h>", "<Left>", { noremap = true, silent = true })
    map("i", "<C-l>", "<Right>", { noremap = true, silent = true })

    -- EasyAlign mappings
    -- Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
    map("v", "<Enter>", "<Plug>(EasyAlign)")
    -- Start interactive EasyAlign in visual mode (e.g. vipga)
    map("x", "ga", "<Plug>(EasyAlign)")
    -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
    map("n", "ga", "<Plug>(EasyAlign)")

    -- Set autocommands
    local augroup = vim.api.nvim_create_augroup
    local TrimWhitespace = augroup("TrimWhitespace", { clear = true })

    local autocmd = vim.api.nvim_create_autocmd

    autocmd({ "BufWritePre" }, {
      group = TrimWhitespace,
      pattern = "*",
      command = [[%s/\s\+$//e]],
    })

    -- Save cursor position
    -- taken from lewis6991 https://github.com/neovim/neovim/issues/16339#issuecomment-1348133829
    local ignore_buftype = { "quickfix", "nofile", "help" }
    local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

    local function run()
      if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then return end

      if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
        -- reset cursor to first line
        vim.cmd [[normal! gg]]
        return
      end

      -- If a line has already been specified on the command line, we are done
      --   nvim file +num
      if vim.fn.line "." > 1 then return end

      local last_line = vim.fn.line [['"]]
      local buff_last_line = vim.fn.line "$"

      -- If the last line is set and the less than the last line in the buffer
      if last_line > 0 and last_line <= buff_last_line then
        local win_last_line = vim.fn.line "w$"
        local win_first_line = vim.fn.line "w0"
        -- Check if the last line of the buffer is the same as the win
        if win_last_line == buff_last_line then
          -- Set line to last line edited
          vim.cmd [[normal! g`"]]
          -- Try to center
        elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
          vim.cmd [[normal! g`"zz]]
        else
          vim.cmd [[normal! G'"<c-e>]]
        end
      end
    end

    autocmd({ "BufWinEnter", "FileType" }, {
      group = vim.api.nvim_create_augroup("nvim-lastplace", {}),
      callback = run,
    })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
