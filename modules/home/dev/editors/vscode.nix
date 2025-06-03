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
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc-icons
        catppuccin.catppuccin-vsc
        jnoortheen.nix-ide
        vscodevim.vim
        vscjava.vscode-java-pack
        redhat.java
      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
      };
    };
  };
}
