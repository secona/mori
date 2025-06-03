{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.desktop.wms.sway = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.wms.sway.enable {
    desktop.media.flameshot.enable = true;
    desktop.files.nemo.enable = true;
    desktop.status-bar.i3status-rust.enable = true;
    desktop.launcher.wofi.enable = true;
    desktop.notifications.swaync.enable = true;
    desktop.ui.gtk.enable = true;
    desktop.utils.wlogout.enable = true;
    desktop.utils.ctl.enable = true;

    wayland.windowManager.sway = {
      enable = true;

      config =
        let
          kitty = "${pkgs.kitty}/bin/kitty";
          wpctl = "${pkgs.wireplumber}/bin/wpctl";
          brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
          wlogout = "${pkgs.wlogout}/bin/wlogout";
          flameshot = "${pkgs.flameshot}/bin/flameshot";
        in
        rec {
          modifier = "Mod4";
          terminal = kitty;

          bars = [
            {
              fonts = {
                names = [ "JetBrainsMono Nerd Font" ];
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
              scroll_factor = "0.2";
            };

            "type:keyboard" = {
              xkb_layout = "us";
              xkb_variant = ",";
              xkb_options = "grp:win_space_toggle";
            };
          };

          output = {
            "*" = {
              bg = "${../../../../wallpapers/pixel-car.png} fill";
            };
          };

          window = {
            titlebar = true;
            border = 2;
            hideEdgeBorders = "smart";

            commands = [
              {
                criteria.class = ".*";
                command = "inhibit_idle fullscreen";
              }
              {
                criteria.shell = "xwayland";
                command = "title_format [XWayland] %title";
              }
            ];
          };

          workspaceLayout = "tabbed";

          # colors = {
          #   focused = {
          #     border = "#89b4fa";
          #     background = "#11111b";
          #     text = "#ffffff";
          #     indicator = "#2e9ef4";
          #     childBorder = "#89b4fa";
          #   };
          #   focusedInactive = {
          #     border = "#333333";
          #     background = "#5f676a";
          #     text = "#ffffff";
          #     indicator = "#484e50";
          #     childBorder = "#5f676a";
          #   };
          #   unfocused = {
          #     border = "#333333";
          #     background = "#222222";
          #     text = "#888888";
          #     indicator = "#292d2e";
          #     childBorder = "#222222";
          #   };
          #   urgent = {
          #     border = "#2f343a";
          #     background = "#900000";
          #     text = "#ffffff";
          #     indicator = "#900000";
          #     childBorder = "#900000";
          #   };
          #   placeholder = {
          #     border = "#000000";
          #     background = "#0c0c0c";
          #     text = "#ffffff";
          #     indicator = "#000000";
          #     childBorder = "#0c0c0c";
          #   };
          #   background = "#ffffff";
          # };

          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
            size = 8.0;
          };

          keybindings = {
            "${modifier}+r" = "exec wofi";
            "${modifier}+c" = "kill";
            "${modifier}+q" = "exec ${kitty}";
            "${modifier}+Escape" = "exec ${wlogout}";
            "${modifier}+n" = "exec swaync-client -t -sw";

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
            "${modifier}+Ctrl+h" = "workspace prev";
            "${modifier}+Ctrl+l" = "workspace next";

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

            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";
            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+l" = "move right";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+k" = "move up";

            "${modifier}+Left" = "focus left";
            "${modifier}+Right" = "focus right";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+h" = "focus left";
            "${modifier}+l" = "focus right";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";

            "${modifier}+f" = "fullscreen";
            "${modifier}+w" = "layout tabbed";
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
      enable = false;
      events = [ ];
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
      enable = false;

      settings = {
        font = "JetBrainsMono Nerd Font";
        font-size = 14;
        indicator-radius = 100;
        image = "${../../../../wallpapers/japan-alley.png}";
        indicator-thickness = 5;
      };
    };

    programs.swayr = {
      enable = false;

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

    services.swayosd = {
      enable = false;
    };
  };
}
