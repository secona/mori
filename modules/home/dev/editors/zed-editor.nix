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
      extensions = [ "nix" "astro" "haskell" "nushell" "discord-presence" "html" ];
      userSettings = {
        vim_mode = true;
      };
    };
  };
}
