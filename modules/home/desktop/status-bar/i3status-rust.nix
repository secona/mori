{
  lib,
  config,
  ...
}: {
  options.desktop.status-bar.i3status-rust = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.status-bar.i3status-rust.enable {
    programs.i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            {
              block = "music";
              format = " $icon {$play $combo.str(max_w:20)} ";
              theme_overrides.idle_fg = "#cdd6f4";
            }
            {
              block = "sound";
            }
            {
              block = "cpu";
              interval = 1;
              theme_overrides.idle_fg = "#fab387";
            }
            {
              block = "memory";
              format = " $icon $mem_used_percents  $icon_swap $swap_used_percents ";
              theme_overrides.idle_fg = "#fab387";
            }
            {
              block = "disk_space";
              info_type = "available";
              format = " $icon $percentage ";
              path = "/";
              interval = 60;
              theme_overrides.idle_fg = "#fab387";
            }
            {
              block = "net";
              format = " $icon {$signal_strength $ssid} ";
              theme_overrides.idle_fg = "#f5e0dc";
            }
            {
              block = "battery";
              format = " $icon $percentage ";
              full_threshold = 95;
            }
            {
              block = "time";
              format = " $icon $timestamp.datetime(f:'%a %d/%m %R') ";
              interval = 60;
              theme_overrides.idle_fg = "#89b4fa";
            }
          ];
          theme = "ctp-mocha";
          icons = "material-nf";
          settings = {
            theme = {
              theme = "ctp-mocha";
              overrides = {
                idle_bg = "#11111b";
                idle_fg = "#cdd6f4";
                info_bg = "#11111b";
                info_fg = "#89b4fa";
                good_bg = "#11111b";
                good_fg = "#a6e3a1";
                warning_bg = "#11111b";
                warning_fg = "#eba0ac";
                critical_bg = "#11111b";
                critical_fg = "#f38ba8";
                separator = "";
                separator_bg = "auto";
                separator_fg = "auto";
              };
            };
          };
        };
      };
    };
  };
}

