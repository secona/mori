{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

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
                icon = " ";
              };
              "vim.diagnostic.severity.WARN" = {
                enabled = true;
                icon = " ";
              };
              "vim.diagnostic.severity.INFO" = {
                enabled = false;
                icon = " ";
              };
              "vim.diagnostic.severity.HINT" = {
                enabled = true;
                icon = " ";
              };
            };
            gitsigns = {
              added = {
                enabled = true;
                icon = " ";
              };
              changed = {
                enabled = true;
                icon = " ";
              };
              deleted = {
                enabled = true;
                icon = " ";
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

      plugins.cmp-buffer.enable = true;
      plugins.cmp-path.enable = true;
      plugins.cmp_luasnip.enable = true;
      plugins.luasnip.enable = true;
      plugins.lspkind.enable = true;
      plugins.nvim-autopairs.enable = true;

      plugins.cmp = {
        enable = true;
        settings = {
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
              end, { "i", "s", "c" }),
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
          sources = [
            { name = "cmp_luasnip"; }
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
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
        capabilities = ''
          capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
          )
        '';

        preConfig = ''
          vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            float = {
              border = 'rounded',
              source = 'always',
            },
          })

          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            {border = 'rounded'}
          )

          vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            {border = 'rounded'}
          )
        '';

        servers.rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
          package = pkgs.unstable.rust-analyzer;

          settings = {
            cargo.features = "all";
            diagnostics.disabled = [ "unlinked-file" ];
          };
        };

        keymaps = {
          lspBuf = {
            "<F2>" = "rename";
            "<C-Space>" = "hover";
            "<Leader>df" = "definition";
            "<Leader>dc" = "declaration";
            "<Leader>ca" = "code_action";
          };
          diagnostic = {
            "<Leader>ee" = "open_float";
            "<Leader>ej" = "goto_next";
            "<Leader>ek" = "goto_prev";
          };
        };
      };

      plugins.fidget = {
        enable = true;
        settings.notification = {
          window = {
            maxWidth = 50;
            winblend = 0;
            border = "rounded";
          };
        };
      };

      plugins.comment = {
        enable = true;
      };

      plugins.barbecue = {
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

      plugins.telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
          };
          "<leader>fg" = {
            action = "live_grep";
          };
          "<leader>fb" = {
            action = "buffers";
          };
          "<leader>fh" = {
            action = "help_tags";
          };
          "<leader>rf" = {
            action = "lsp_references";
          };
        };
      };

      plugins.image = {
        enable = true;
      };

      plugins.toggleterm = {
        enable = true;
        settings = {
          float_opts.border = "rounded";
          direction = "float";
          open_mapping = "[[<C-_>]]";
          shell = "zsh";
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
