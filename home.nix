{ inputs, config, pkgs, system, ... }:

let
  nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
    inherit pkgs;
    module = import ./nixvim;
  };
in {
  imports = [
    # (import ./hypr.nix { inherit pkgs; })
    (import ./sway.nix { inherit pkgs; })
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "secona";
  home.homeDirectory = "/home/secona";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    nvim
    pkgs.xournalpp
    pkgs.libreoffice
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/secona/etc/profile.d/hm-session-vars.sh
  #

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

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
