{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dolphin
    playerctl
    brightnessctl
    flameshot
  ];

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  wayland.windowManager.sway = {
    enable = true;

    config = rec {
      modifier = "Mod4";
      terminal = "kitty"; 

      bars = [];

      gaps = {
        inner = 5;
        outer = 5;
      };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };

      output = {
        "*" = {
          bg = "${./wallpapers/kurzgezagt.png} fill";
        };
      };

      window = {
        titlebar = false;
        border = 1;
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
        "${modifier}+r" = "exec fuzzel";
        "${modifier}+c" = "kill";
        "${modifier}+q" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+Escape" = "exec ${pkgs.wlogout}/bin/wlogout";

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

        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl s 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";

        "Print" = "exec flameshot gui";
      };
    };

    extraConfig = ''
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next

      exec eww open bar
    '';
  };

  services.swayidle = {
    enable = true;
    # events = [
    #   {
    #     event = "before-sleep";
    #     command = "${pkgs.swaylock}/bin/swaylock";
    #   }
    # ];
    # timeouts = [
    #   {
    #     timeout = 30;
    #     command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 0%";
    #     resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
    #   }
    #   {
    #     timeout = 60;
    #     command = "${pkgs.systemd}/bin/systemctl suspend";
    #   }
    # ];
  };

  programs.swaylock = {
    enable = true;
    catppuccin.enable = true;

    settings = {
      font = "JetBrainsMono Nerd Font";
      font-size = 14;
      indicator-radius = 100;
      image = "${./wallpapers/kurzgezagt.png}";
      indicator-thickness = 5;
    };
  };

  programs.wlogout = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;
    catppuccin.enable = true;

    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        font = "JetBrainsMono Nerd Font:size=10";
      };
      colors = {
        background = "11111bff";
      };
      border = {
        width = 1;
        radius = 0;
      };
    };
  };

  programs.eww = {
    enable = true;
    configDir = ./config/eww;
  };

  services.dunst = {
    enable = true;
    catppuccin.enable = true;

    settings = {
      global = {
        font = "JetBrainsMono Nerd Font 10";
        origin = "top-center";
        frame_width = 1;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
      };
    };
  };
}
