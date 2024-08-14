{ ... }:

{
  plugins.barbar = {
    enable = true;
    keymaps = {
      previous = {
        key = "<A-j>";
        mode = "n";
      };
      next = {
        key = "<A-k>";
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
}