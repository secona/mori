{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.editors.vscode = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    extraExtensions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
    };
  };

  config = lib.mkIf config.dev.editors.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        ms-vscode-remote.remote-ssh
        # catppuccin.catppuccin-vsc-icons
        # catppuccin.catppuccin-vsc
        jnoortheen.nix-ide
        vscodevim.vim
        vscjava.vscode-java-pack
        redhat.java
      ];
      profiles.default.userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "editor.fontLigatures" = true;
        # "workbench.colorTheme" = "Catppuccin Mocha";
        # "workbench.iconTheme" = "catppuccin-mocha";
      };
    };
  };
}
