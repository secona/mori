{...}: {
  imports = [
    ./../../modules/home/apps
    ./../../modules/home/cli
    ./../../modules/home/dev
    ./../../modules/home/editors
    ./../../modules/home/games
    ./../../modules/home/terminals
    ./../../modules/home/ui
    ./../../modules/home/wms
  ];

  programs.home-manager.enable = true;

  apps.discord.enable = true;
  apps.google-chrome.enable = true;
  apps.jflap.enable = true;
  apps.libreoffice.enable = true;
  apps.miru.enable = true;
  apps.vlc.enable = true;
  apps.xournalpp.enable = true;
  apps.yazi.enable = true;
  apps.zathura.enable = true;
  apps.zoom-us.enable = true;

  cli.bat.enable = true;
  cli.btop.enable = true;
  cli.eza.enable = true;
  cli.gh-dash.enable = true;
  cli.starship.enable = true;
  cli.tmux.enable = true;
  cli.zoxide.enable = true;
  cli.zsh.enable = true;

  dev.git.userName = "secona";
  dev.git.userEmail = "77039267+secona@users.noreply.github.com";
  dev.git.enable = true;
  dev.direnv.enable = true;
  dev.lazygit.enable = true;
  dev.postman.enable = true;

  editors.nvim.enable = true;
  editors.idea-ultimate.enable = true;
  editors.vscode.enable = true;

  games.minecraft.enable = true;

  terminals.kitty.enable = true;

  ui.catppuccin.enable = true;

  wms.sway.enable = true;

  home = {
    username = "secona";
    homeDirectory = "/home/secona";
    stateVersion = "24.05";
  };
}
