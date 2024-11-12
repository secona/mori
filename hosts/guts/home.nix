{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    (import ./../../modules/home/wms/sway.nix {inherit pkgs;})
    (import ./../../modules/home/editors/nvim {inherit inputs;})
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.username = "secona";
  home.homeDirectory = "/home/secona";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.xournalpp
    pkgs.libreoffice
  ];

  home.file = {};

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.pointerCursor.enable = true;
  catppuccin.pointerCursor.accent = "dark";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Git
  programs.git = {
    enable = true;
    userName = "secona";
    userEmail = "77039267+secona@users.noreply.github.com";
    package = pkgs.gitFull;
  };

  # Btop
  programs.btop = {
    enable = true;
  };

  # VSCode
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      vscodevim.vim
    ];
  };

  # Kitty
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    catppuccin.enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
    };
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      hide_window_decorations = "yes";
      background_opacity = "0.9";
      background_tint = "0.99";
      background_blur = "1";
    };
  };

  # Google Chrome
  programs.google-chrome = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    catppuccin.enable = true;
  };
}
