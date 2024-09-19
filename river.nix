{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dolphin
    rofi-power-menu
    rofi-emoji
    playerctl
    brightnessctl
  ];

  wayland.windowManager.river = {
    enable = true;
    settings = {
      map = {
        normal = {
          "Super R" = "spawn \"rofi -show drun\"";
        };
      };
    };
  };

  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    catppuccin.enable = true;
    terminal = "kitty";
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
        origin = "top-center";
        corner_radius = 12;
      };
    };
  };
}
