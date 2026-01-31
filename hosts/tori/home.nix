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

  cli.shells.fish.enable = true;
  cli.tools.tmux.enable = true;
  cli.tools.starship.enable = true;
  cli.tools.eza.enable = true;

  dev.editors.nvim.enable = true;
  dev.tools.direnv.enable = true;

  dev.vcs =
    let
      userName = "Vito Secona";
      userEmail = "secona00@gmail.com";
    in
    {
      git = {
        enable = true;
        inherit userName userEmail;
      };

      jujutsu = {
        enable = true;
        inherit userName userEmail;
      };
    };

  desktop.ui.catppuccin.enable = true;
}
