{
  lib,
  config,
  ...
}: {
  options.desktop.launcher.wofi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.launcher.wofi.enable {
    programs.wofi = {
      enable = true;
      style = builtins.readFile ../../../../config/wofi/style.css;
      settings = {
        show = "drun";
        width = 400;
        height = 600;
        always_parse_args = true;
        show_all = true;
        term = "kitty";
        hide_scroll = true;
        no_actions = true;
        print_command = true;
        insensitive = true;
        prompt = "";
        columns = 1;
        allow_images = true;
      };
    };
  };
}
