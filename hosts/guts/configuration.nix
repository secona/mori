{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      devices = ["nodev"];
      efiSupport = true;
      configurationLimit = 5;
    };

    efi.canTouchEfiVariables = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "guts";
    networkmanager.enable = true;
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };

    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];

      xkb = {
        layout = "us";
        variant = "";
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;
    blueman.enable = true;
    postgresql.enable = true;
  };

  hardware = {
    opengl.enable = true;
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = {};
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;

    config = {
      common = {
        default = "wlr";
      };
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-xapp
    ];
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      inter
      roboto
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
    };

    virtualbox = {
      guest = {
        enable = true;
        clipboard = true;
      };
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
  };

  users = {
    users.secona = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "secona";
      extraGroups = ["networkmanager" "wheel" "docker" "vboxusers"];
    };
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      pulseaudio
      tldr
      unzip
      wget
      ripgrep
      openssl
      zlib
      jq
      socat
      devenv
      zoxide
      logisim-evolution
      libnotify
      wl-clipboard
      man-pages
      man-pages-posix
    ];
  };

  documentation.dev.enable = true;

  programs = {
    firefox.enable = true;

    starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../../config/starship.toml;
    };

    # TMUX
    tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      terminal = "screen-256color";

      extraConfigBeforePlugins = ''
        set -gq allow-passthrough on
        set -g visual-activity off

        set -g @resurrect-save-interval 15
        set -g @continuum-restore 'on'

        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_status_left_separator "█"
        set -g @catppuccin_status_right_separator "█"

        set -g base-index 1
        setw -g pane-base-index 1

        set -g status-keys vi
        setw -g mode-keys vi
        setw -g mouse on
        setw -g monitor-activity on

        # Shift + Alt
        bind-key -n M-H resize-pane -L
        bind-key -n M-J resize-pane -D
        bind-key -n M-K resize-pane -U
        bind-key -n M-L resize-pane -R

        # Control + Alt
        bind-key -n C-M-l next-window
        bind-key -n C-M-h previous-window

        unbind -n M-h
        unbind -n M-l

        bind-key v split-window -v -c "#{pane_current_path}"
        bind-key h split-window -h -c "#{pane_current_path}"
      '';

      plugins = with pkgs.tmuxPlugins; [
        sensible
        resurrect
        continuum
        vim-tmux-navigator
        catppuccin
      ];
    };

    # ZSH
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellInit = ''
        ZSH_TMUX_AUTOSTART=true
        ZSH_TMUX_AUTOSTART_ONCE=false
        ZSH_TMUX_AUTOCONNECT=true
        ZOXIDE_CMD_OVERRIDE=cd
      '';

      ohMyZsh = {
        enable = true;
        plugins = ["git" "tmux" "zoxide"];
      };
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
