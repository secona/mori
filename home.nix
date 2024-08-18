{ inputs, config, pkgs, system, ... }:

let
  nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
    inherit pkgs;
    module = import ./nixvim;
  };
in {
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
  
  home.sessionVariables = {
    GTK_THEME = "catppuccin";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Git
  programs.git = {
    enable = true;
    userName = "secona";
    userEmail = "77039267+secona@users.noreply.github.com";
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
    font = {
      name = "JetBrainsMono Nerd Font";
    };
  };

  # Google Chrome
  programs.google-chrome = {
    enable = true;
  };

  # Ricing
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          tray-icons-reloaded.extensionUuid
          media-controls.extensionUuid
          logo-menu.extensionUuid
          system-monitor.extensionUuid
          dash-to-dock.extensionUuid
          space-bar.extensionUuid
          pop-shell.extensionUuid
        ];
      };

      "org/gnome/desktop/wm/keybindings" = {
        minimize = [];
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 0.75;
        noise-amount = 0;
      };

      "org/gnome/shell/extensions/Logo-menu" = {
        menu-button-icon-image = 23;
        menu-button-icon-size = 20;
        symbolic-icon = true;
        use-custom-icon = false;
      };
    };
  };

  gtk = {
    enable = true;

    catppuccin = {
      enable = true;
      flavor = "mocha";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
