{...}: {
  imports = [
    ./../../modules/home/apps
    ./../../modules/home/cli
    ./../../modules/home/dev
    ./../../modules/home/editors
    ./../../modules/home/terminals
    ./../../modules/home/ui
    ./../../modules/home/wms
  ];

  programs.home-manager.enable = true;

  dev.git.userName = "secona";
  dev.git.userEmail = "77039267+secona@users.noreply.github.com";
  wms.sway.enable = true;

  home = {
    username = "secona";
    homeDirectory = "/home/secona";
    stateVersion = "24.05";
  };
}
