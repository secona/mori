{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.editors.zed-editor = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.editors.zed-editor.enable {
    programs.zed-editor = {
      enable = true;
      package = pkgs.unstable.zed-editor;
      extraPackages = with pkgs.unstable; [
        php
        phpactor
      ];
      extensions = [
        "nix"
        "astro"
        "haskell"
        "nushell"
        "vue"
        "php"
        "html"
      ];
      userSettings = {
        vim_mode = true;
      };
    };
  };
}
