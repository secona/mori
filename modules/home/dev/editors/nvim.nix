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
        ];

      plugins.presence-nvim = {
        enable = true;
      };

      plugins.barbar = {
        enable = true;
        keymaps = {
          previous = {
            key = "<A-h>";
            mode = "n";
          };
          movePrevious = {
            key = "<A-j>";
            mode = "n";
          };
          moveNext = {
            key = "<A-k>";
            mode = "n";
          };
          next = {
            key = "<A-l>";
            mode = "n";
          };
          goTo1 = {
            key = "<A-1>";
            mode = "n";
          };
          goTo2 = {
            key = "<A-2>";
            mode = "n";
          };
          goTo3 = {
            key = "<A-3>";
            mode = "n";
          };
          goTo4 = {
            key = "<A-4>";
            mode = "n";
          };
          goTo5 = {
            key = "<A-5>";
            mode = "n";
          };
          goTo6 = {
            key = "<A-6>";
            mode = "n";
          };
          goTo7 = {
            key = "<A-7>";
            mode = "n";
          };
          goTo8 = {
            key = "<A-8>";
            mode = "n";
          };
          goTo9 = {
            key = "<A-9>";
            mode = "n";
          };
          last = {
            key = "<A-0>";
            mode = "n";
          };
          pin = {
            key = "<A-p>";
            mode = "n";
          };
          close = {
            key = "<A-c>";
            mode = "n";
          };
          closeAllButCurrent = {
            key = "<leader>bc";
            mode = "n";
          };
          orderByBufferNumber = {
            key = "<leader>bb";
            mode = "n";
          };
          orderByName = {
            key = "<leader>bn";
            mode = "n";
          };
          orderByDirectory = {
            key = "<leader>bd";
            mode = "n";
          };
          orderByLanguage = {
            key = "<leader>bl";
            mode = "n";
          };
          orderByWindowNumber = {
            key = "<leader>bw";
            mode = "n";
          };
        };
        settings = {
          icons = {
            buffer_index = true;
            buffer_number = false;
            button = "";
            diagnostics = {
              "vim.diagnostic.severity.ERROR" = {
                enabled = true;
              };
              "vim.diagnostic.severity.WARN" = {
                enabled = true;
              };
              "vim.diagnostic.severity.INFO" = {
                enabled = false;
              };
              "vim.diagnostic.severity.HINT" = {
                enabled = true;
              };
            };
            gitsigns = {
              added = {
                enabled = true;
              };
              changed = {
                enabled = true;
              };
              deleted = {
                enabled = true;
              };
            };
            filetype = {
              custom_colors = false;
              enabled = true;
            };
            separator = {
              left = "▎";
              right = "";
            };
            modified = {
              button = "●";
            };
            pinned = {
              button = "";
              filename = true;
            };
            preset = "default";
            alternate.filetype.enabled = false;
            current.buffer_index = true;
            inactive.button = "×";
            visible.modified.buffer_number = false;
          };
        };
      };

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

      plugins.lsp = {
        enable = true;

        servers.rust_analyzer = {
          enable = true;
          package = pkgs.unstable.rust-analyzer;
          installCargo = false;
          installRustc = false;

          settings = {
            cargo.features = "all";
            diagnostics.disabled = [ "unlinked-file" ];
          };
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

        keymaps.extra = [
          {
            key = "<F2>";
            action = "<CMD>Lspsaga rename<Enter>";
          }
          {
            key = "<C-Space>";
            action = "<CMD>Lspsaga hover_doc<Enter>";
          }
          {
            key = "<Leader>df";
            action = "<CMD>Lspsaga goto_definition<Enter>";
          }
          {
            key = "<Leader>dt";
            action = "<CMD>Lspsaga goto_type_definition<Enter>";
          }
          {
            key = "<Leader>pf";
            action = "<CMD>Lspsaga peek_definition<Enter>";
          }
          {
            key = "<Leader>pt";
            action = "<CMD>Lspsaga peek_type_definition<Enter>";
          }
          {
            key = "<Leader>ca";
            action = "<CMD>Lspsaga code_action<Enter>";
          }
          {
            key = "<Leader>ek";
            action = "<CMD>Lspsaga diagnostic_jump_prev<Enter>";
          }
          {
            key = "<Leader>ej";
            action = "<CMD>Lspsaga diagnostic_jump_next<Enter>";
          }
        ];
      };

      plugins.lspsaga = {
        enable = true;
        ui.border = "rounded";
        ui.codeAction = null;
        ui.actionfix = null;
        lightbulb.enable = false;
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

      plugins.comment = {
        enable = true;
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
          shell = "${pkgs.nushell}/bin/nu";
        };
      };

      plugins.neo-tree = {
        enable = true;
        enableGitStatus = true;
        enableDiagnostics = true;
        defaultComponentConfigs = {
          icon = {
            folderClosed = "";
            folderOpen = "";
            folderEmpty = "";
          };
          gitStatus.symbols = {
            untracked = "";
            ignored = "";
            unstaged = "󰄱";
            staged = "";
            conflict = "";
          };
          indent.withExpanders = true;
        };
        filesystem = {
          filteredItems = {
            hideDotfiles = false;
            hideGitignored = false;
            hideByName = [ ".git" ];
          };
        };
      };

      plugins.treesitter = {
        enable = true;
        settings.indent.enable = true;
      };

      plugins.treesitter-context = {
        enable = true;
        settings = {
          mode = "topline";
          on_attach = ''
            function()
              vim.cmd([[ hi TreesitterContextBottom gui=underline guisp=#cba6f7 ]])
            end
          '';
        };
      };

      plugins.rainbow-delimiters = {
        enable = true;
      };

      plugins.ts-autotag = {
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
            barbar = true;
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
            illuminate = {
              enabled = true;
              lsp = false;
            };
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

      plugins.lualine = {
        enable = true;
      };

      plugins.indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "▏";
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

      plugins.illuminate = {
        enable = true;
      };

      plugins.web-devicons = {
        enable = true;
      };
    };
  };
}
