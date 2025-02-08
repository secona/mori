{pkgs, ...}: {
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
    graphics.enable = true;
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
      xdg-desktop-portal-kde
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

    dconf.enable = true;

    zsh.enable = true;

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
