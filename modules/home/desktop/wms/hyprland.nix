{
  lib,
  config,
  ...
}: {
  options.desktop.wms.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.wms.hyprland.enable {
    desktop.utils.ctl.enable = true;
    desktop.files.nemo.enable = true;
    desktop.launcher.wofi.enable = true;
    desktop.notifications.swaync.enable = true;
    desktop.ui.gtk.enable = true;
    desktop.utils.wlogout.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        monitor = ", 1920x1080@60, auto, 1";

        "$mod" = "SUPER";
        "$terminal" = "kitty";
        "$fileManager" = "nemo";
        "$menu" = "wofi";
        "$powerMenu" = "wlogout";

        exec-once = [
          "hyprpaper"
        ];

        general = {
          gaps_out = 10;
          resize_on_border = true;
        };

        animations = {
          enabled = true;
        };

        input = {
          touchpad = {
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_distance = 100;
        };

        decoration = {
          rounding = 12;
        };

        misc = {
          disable_hyprland_logo = true;
        };

        debug = {
          disable_logs = false;
        };

        bind = [
          "$mod, Q, exec, $terminal"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, E, exec, $fileManager"
          "$mod, V, togglefloating"
          "$mod, R, exec, $menu"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
          "$mod, F, fullscreen"
          "$mod, escape, exec, $powerMenu"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"

          "$mod CTRL, right, workspace, e+1"
          "$mod CTRL, left, workspace, e-1"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          ", Print, exec, grim -g \"$(slurp)\" ~/Pictures/Screenshots/`date +%s`.png | wl-copy"
        ];

        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ];

        bindl = [
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPrev, exec, playerctl previous"
        ];
      };
    };

    programs.hyprlock = {
      enable = true;
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        preload = [
          "${../../../../wallpapers/japan-alley.png}"
        ];
        wallpaper = [
          ", ${../../../../wallpapers/japan-alley.png}"
        ];
      };
    };
  };
}
