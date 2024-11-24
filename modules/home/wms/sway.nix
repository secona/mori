{
  lib,
  config,
  pkgs,
  ...
}: {
  options.wms.sway = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.wms.sway.enable {
    home.packages = with pkgs; [
      cinnamon.nemo
      playerctl
      brightnessctl
      flameshot
    ];

    gtk = {
      enable = true;

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    wayland.windowManager.sway = {
      enable = true;

      config = let
        kitty = "${pkgs.kitty}/bin/kitty";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        wlogout = "${pkgs.wlogout}/bin/wlogout";
        flameshot = "${pkgs.flameshot}/bin/flameshot";
      in rec {
        modifier = "Mod4";
        terminal = kitty;

        bars = [
          {
            fonts = {
              names = ["JetBrainsMono Nerd Font"];
              size = 9.0;
            };
            position = "bottom";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
            colors.background = "#11111b";
          }
        ];

        input = {
          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };
        };

        output = {
          "*" = {
            bg = "${../../../wallpapers/kurzgezagt.png} fill";
          };
        };

        window = {
          titlebar = false;
          border = 2;
          hideEdgeBorders = "smart";
        };

        colors = {
          focused = {
            border = "#89b4fa";
            background = "#11111b";
            text = "#ffffff";
            indicator = "#2e9ef4";
            childBorder = "#89b4fa";
          };
          focusedInactive = {
            border = "#333333";
            background = "#5f676a";
            text = "#ffffff";
            indicator = "#484e50";
            childBorder = "#5f676a";
          };
          unfocused = {
            border = "#333333";
            background = "#222222";
            text = "#888888";
            indicator = "#292d2e";
            childBorder = "#222222";
          };
          urgent = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
            indicator = "#900000";
            childBorder = "#900000";
          };
          placeholder = {
            border = "#000000";
            background = "#0c0c0c";
            text = "#ffffff";
            indicator = "#000000";
            childBorder = "#0c0c0c";
          };
          background = "#ffffff";
        };

        fonts = {
          names = ["JetBrainsMono Nerd Font"];
          size = 8.0;
        };

        keybindings = {
          "${modifier}+r" = "exec wofi";
          "${modifier}+c" = "kill";
          "${modifier}+q" = "exec ${kitty}";
          "${modifier}+Escape" = "exec ${wlogout}";
          "${modifier}+n" = "exec swaync-client -t -sw";

          "${modifier}+Left" = "focus left";
          "${modifier}+Right" = "focus right";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Ctrl+Left" = "workspace prev";
          "${modifier}+Ctrl+Right" = "workspace next";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          "${modifier}+f" = "fullscreen";
          "${modifier}+h" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+Shift+space" = "floating toggle";

          "XF86AudioRaiseVolume" = "exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86MonBrightnessUp" = "exec ${brightnessctl} s 5%+";
          "XF86MonBrightnessDown" = "exec ${brightnessctl} s 5%-";

          "Print" = "exec ${flameshot} gui";
        };
      };

      extraSessionCommands = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';

      extraConfig = ''
        bindgesture swipe:right workspace prev
        bindgesture swipe:left workspace next
      '';
    };

    services.swayidle = {
      enable = true;
      events = [
        # {
        #   event = "before-sleep";
        #   command = "${pkgs.swaylock}/bin/swaylock -fF";
        # }
      ];
      timeouts = [
        {
          timeout = 30;
          command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 0%";
          resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        {
          timeout = 60;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };

    programs.swaylock = {
      enable = true;
      catppuccin.enable = true;

      settings = {
        font = "JetBrainsMono Nerd Font";
        font-size = 14;
        indicator-radius = 100;
        image = "${../../../wallpapers/kurzgezagt.png}";
        indicator-thickness = 5;
      };
    };

    programs.wlogout = {
      enable = true;
    };

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

    programs.swayr = {
      enable = true;

      settings = {
        menu = {
          executable = "${pkgs.wofi}/bin/wofi";
          args = [
            "--show=dmenu"
            "--allow-markup"
            "--allow-images"
            "--insensitive"
            "--cache-file=/dev/null"
            "--parse-search"
            "--height=40%"
            "--prompt={prompt}"
          ];
        };
      };
    };

    programs.wofi = {
      enable = true;
      style = builtins.readFile ../../../config/wofi/style.css;
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

    services.swaync = {
      enable = true;
      style = builtins.readFile ../../../config/swaync/style.css;
      settings = {
        positionY = "bottom";
      };
    };

    services.swayosd = {
      enable = true;
    };
  };
}
