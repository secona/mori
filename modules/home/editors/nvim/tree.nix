{...}: {
  programs.nixvim = {
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
          hideByName = [".git"];
        };
      };
    };

    plugins.yazi = {
      enable = true;
    };
  };
}
