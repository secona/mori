{
  pkgs,
  ...
}:
{
  imports = [ ../../modules/home ];

  programs.home-manager.enable = true;

  home = {
    username = "guest";
    homeDirectory = "/home/guest";
    stateVersion = "25.11";
  };

  desktop.ui.catppuccin.enable = true;
}
