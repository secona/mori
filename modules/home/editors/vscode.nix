{pkgs, lib, config, ...}: {
  options.editors.vscode = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    extraExtensions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
    };
  };

  config = lib.mkIf config.editors.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        vscodevim.vim
      ];
    };
  };
}
