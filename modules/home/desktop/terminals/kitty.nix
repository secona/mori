{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.terminals.kitty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.terminals.kitty.enable {
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
      font = {
        name = "JetBrainsMono Nerd Font";
      };
      settings = {
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        hide_window_decorations = "yes";
        background_opacity = "0.9";
        background_tint = "0.99";
        background_blur = "1";
      };
    };
  };
}
