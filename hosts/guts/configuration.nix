# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  pkgs-unstable,
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

  # Nix
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "guts"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.blueman.enable = true;

  services.postgresql.enable = true;

  hardware.opengl.enable = true;

  # Enable sound with pipewire.
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

  virtualisation.docker = {
    enable = true;
  };

  virtualisation.virtualbox = {
    guest = {
      enable = true;
      clipboard = true;
    };
    host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.secona = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "secona";
    extraGroups = ["networkmanager" "wheel" "docker" "vboxusers"];
  };

  users.extraGroups.docker.members = ["secona"];
  users.extraGroups.vboxusers.members = ["secona"];

  # Install firefox.
  programs.firefox.enable = true;

  programs.dconf.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs;
    [
      pulseaudio
      tldr
      unzip
      git
      wget
      discord
      home-manager
      nil
      ripgrep
      openssl
      zlib
      jq
      socat
      devenv
      zoxide
      vlc
      bruno
      logisim-evolution
      zathura
      libnotify
      grim
      slurp
      wl-clipboard
      postman
      zoom-us

      wine
      winetricks
      wineWowPackages.stable
    ]
    ++ (with pkgs-unstable; [
      ]);

  # Starship
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ../../config/starship.toml;
  };

  # TMUX
  programs.tmux = {
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
  programs.zsh = {
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
