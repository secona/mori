{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  nixvim = config.lib.nixvim;
in
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  options.dev.editors.nvim = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.editors.nvim.enable {
    programs.nixvim = {
      enable = true;

      defaultEditor = true;

      extraConfigLua = ''
        require('mini.files').setup({
          windows = {
            preview = true,
            width_focus = 50,
            width_preview = 30,
          },
        })

        local win_config = function()
          local height = math.floor(0.618 * vim.o.lines)
          local width = math.floor(0.618 * vim.o.columns)
          return {
            anchor = 'NW',
            height = height,
            width = width,
            border = 'rounded',
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
          }
        end

        vim.ui.select = MiniPick.ui_select
      '';

      globals = {
        mapleader = " ";
      };

      opts = {
        number = true;
        relativenumber = true;
        tabstop = 4;
        shiftwidth = 4;
        scrolloff = 3;
        signcolumn = "yes";
        wrap = false;
        fillchars = {
          eob = " ";
        };
      };

      keymaps =
        let
          options = {
            noremap = true;
            silent = true;
          };
        in
        [
          {
            mode = "i";
            key = "jj";
            action = "<Esc>";
            inherit options;
          }
          {
            mode = "";
            key = "<Space>";
            action = "<Nop>";
            inherit options;
          }
          {
            mode = "n";
            key = "<M-h>";
            action = "<CMD>bprevious<CR>";
            inherit options;
          }
          {
            mode = "n";
            key = "<M-l>";
            action = "<CMD>bnext<CR>";
            inherit options;
          }
          {
            mode = "n";
            key = "<M-c>";
            action = "<CMD>bdelete<CR>";
            inherit options;
          }
          {
            mode = [
              "n"
              "i"
            ];
            key = "<F2>";
            action = "<CMD>Lspsaga rename<Enter>";
            inherit options;
          }
          {
            mode = [
              "n"
              "i"
            ];
            key = "<C-Space>";
            action = "<CMD>Lspsaga hover_doc<Enter>";
            inherit options;
          }
          {
            mode = [ "n" ];
            key = "<Leader>df";
            action = "<CMD>Lspsaga goto_definition<Enter>";
            inherit options;
          }
          {
            mode = [ "n" ];
            key = "<Leader>dt";
            action = "<CMD>Lspsaga goto_type_definition<Enter>";
            inherit options;
          }
          {
            mode = [ "n" ];
            key = "<Leader>pf";
            action = "<CMD>Lspsaga peek_definition<Enter>";
            inherit options;
          }
          {
            mode = [ "n" ];
            key = "<Leader>pt";
            action = "<CMD>Lspsaga peek_type_definition<Enter>";
            inherit options;
          }
          {
            mode = [ "n" ];
            key = "<Leader>ca";
            action = "<CMD>Lspsaga code_action<Enter>";
            inherit options;
          }
          {
            mode = [ "n" ];
            key = "<Leader>ek";
            action = "<CMD>Lspsaga diagnostic_jump_prev<Enter>";
            inherit options;
          }
          {
            mode = [ "n" ];
            key = "<Leader>ej";
            action = "<CMD>Lspsaga diagnostic_jump_next<Enter>";
            inherit options;
          }
        ];

      extraPlugins = [ pkgs.vimPlugins.neoconf-nvim ];
      extraConfigLuaPre = ''
        require("neoconf").setup()
      '';

      plugins.luasnip.enable = true;
      plugins.lspkind.enable = true;
      plugins.nvim-autopairs.enable = true;

      plugins.cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          sources = [
            { name = "cmp_luasnip"; }
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
          window = {
            completion = {
              border = "rounded";
              scrollbar = true;
            };
            documentation = {
              border = "rounded";
            };
          };
          mapping.__raw = ''
            cmp.mapping.preset.insert({
              ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
              ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
              ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  local entry = cmp.get_selected_entry()
                  if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                  else
                    cmp.confirm()
                  end
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<CR>"] = cmp.mapping({
                i = function(fallback)
                  if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                  else
                    fallback()
                  end
                end,
                s = cmp.mapping.confirm({ select = true }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
              }),
              ["<C-Space>"] = cmp.mapping.complete(),
            })
          '';
          snippet = {
            expand = ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end
            '';
          };
        };
      };

      plugins.presence = {
        enable = true;
      };

      plugins.mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          comment = { };
          cursorword = { };
          icons = { };
          files = {
            enable = true;
          };
          pairs = { };
          pick = {
            mappings = {
              move_down = "<C-j>";
              move_up = "<C-k>";
              scroll_down = "<C-d>";
              scroll_up = "<C-u>";
            };
            window = {
              config = {
                border = "rounded";
              };
            };
          };
          statusline = {
            parts_visible = {
              lsp = "always";
            };
            components = {
              branch = { };
              diagnostics = { };
              filename = { };
              location = { };
              mode = { };
              lsp = { };
            };
          };
          tabline = {
            show_icons = true;
          };
        };
      };

      plugins.gitsigns = {
        enable = true;
        settings = {
          on_attach = ''
            function(bufnr)
              local gs = package.loaded.gitsigns

              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              -- Navigation
              map("n", "<Leader>hj", gs.next_hunk)
              map("n", "<Leader>hl", gs.next_hunk)
              map("n", "<Leader>hh", gs.prev_hunk)
              map("n", "<Leader>hk", gs.prev_hunk)

              -- Hunk previews
              map("n", "<Leader>hP", gs.preview_hunk)
              map("n", "<Leader>hp", gs.preview_hunk_inline)

              -- Reset hunk
              map("n", "<Leader>hr", gs.reset_hunk)
              map("v", "<Leader>hr", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)

              -- Diff
              -- map("n", "<Leader>hd", function() gs.diffthis("~1", { split = "botright" }) end
            end
          '';
          preview_config.border = "rounded";
        };
      };

      lsp = {
        servers.rust_analyzer = {
          enable = true;
          package = null;
        };

        servers.clangd = {
          enable = true;
          package = null;
        };

        servers.gopls = {
          enable = true;
          package = null;
        };

        servers.pyright = {
          enable = true;
        };

        keymaps = [
        ];
      };

      plugins.lspsaga = {
        enable = true;
        settings = {
          ui.border = "rounded";
          ui.codeAction = null;
          ui.actionfix = null;
          lightbulb.enable = false;
        };
      };

      plugins.fidget = {
        enable = true;
        settings.notification = {
          window = {
            max_width = 50;
            winblend = 0;
            border = "rounded";
          };
        };
      };

      plugins.tmux-navigator = {
        enable = true;
      };

      plugins.sleuth = {
        enable = true;
      };

      plugins.vim-surround = {
        enable = true;
      };

      plugins.which-key = {
        enable = true;
        settings.win.border = "single";
      };

      plugins.toggleterm = {
        enable = true;
        settings = {
          float_opts.border = "rounded";
          direction = "float";
          open_mapping = "[[<C-_>]]";
          shell = "${pkgs.fish}/bin/fish";
        };
      };

      plugins.treesitter = {
        enable = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
        settings.indent.enable = true;
      };

      plugins.treesitter-context = {
        enable = true;
        settings = {
          mode = "topline";
          max_lines = 15;
          on_attach = ''
            function()
              vim.cmd([[ hi TreesitterContextBottom gui=underline guisp=#cba6f7 ]])
              vim.cmd([[ hi TreesitterContext guibg=default ]])
            end
          '';
        };
      };

      plugins.rainbow-delimiters = {
        enable = true;
      };

      plugins.tagbar = {
        enable = true;
      };

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavor = "mocha";
          transparent_background = true;
          integrations = {
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            gitsigns = true;
            barbecue = {
              dim_dirname = true;
              bold_basename = true;
              dim_context = false;
              alt_background = false;
            };
            mason = true;
            nvimtree = true;
            neotree = true;
            treesitter = true;
            treesitter_context = true;
            lsp_trouble = true;
            cmp = true;
            rainbow_delimiters = true;
            which_key = true;
            fidget = true;
            telescope = {
              enabled = true;
              style = "nvchad";
            };
          };
        };
      };

      plugins.snacks = {
        enable = true;
        luaConfig.post = ''
          -- Telescope functionality
          vim.keymap.set("n", "<Leader>ff", Snacks.picker.files)
          vim.keymap.set("n", "<Leader>fg", Snacks.picker.grep)
          vim.keymap.set("n", "<Leader>fb", Snacks.picker.buffers)
          vim.keymap.set("n", "<Leader>fh", Snacks.picker.help)
          vim.keymap.set("n", "<Leader>ft", function() require("mini.files").open() end)
          vim.keymap.set("n", "<Leader>rf", Snacks.picker.lsp_references)

          -- Pickers
          vim.keymap.set("n", '<Leader>s"', Snacks.picker.registers)
          vim.keymap.set("n", '<Leader>s/', Snacks.picker.search_history)
          vim.keymap.set("n", '<Leader>sc', Snacks.picker.commands)
          vim.keymap.set("n", '<Leader>sd', Snacks.picker.diagnostics)
          vim.keymap.set("n", '<Leader>su', Snacks.picker.undo)
          vim.keymap.set("n", '<Leader>sj', Snacks.picker.jumps)
          vim.keymap.set("n", "<Leader>:",  Snacks.picker.command_history)

          -- Git stuff
          vim.keymap.set("n", "<Leader>gb", Snacks.picker.git_branches)
          vim.keymap.set("n", "<Leader>gl", Snacks.picker.git_log)
          vim.keymap.set("n", "<Leader>gs", Snacks.picker.git_status)
          vim.keymap.set("n", "<Leader>gd", Snacks.picker.git_diff)

          -- Others
          vim.keymap.set("n", "<Leader>lg", Snacks.lazygit.open)
        '';
      };

      plugins.indent-blankline = {
        enable = true;
        settings.indent.char = "▏";
      };
    };
  };
}
