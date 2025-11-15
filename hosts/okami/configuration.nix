{ pkgs, hostName, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./users/secona.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      grub = {
        enable = true;
        useOSProber = true;
        devices = [ "nodev" ];
        efiSupport = true;
        configurationLimit = 5;
      };

      efi.canTouchEfiVariables = true;
    };
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    auto-optimise-store = true;
    trusted-users = [
      "root"
      "secona"
    ];
  };

  time.timeZone = "Asia/Jakarta";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  services = {
    greetd = {
      enable = false;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };

    displayManager = {
      enable = true;
      ly = {
        enable = true;
        settings = {
          animation = "matrix";
        };
      };
      sessionPackages = with pkgs; [ sway ];
    };

    xserver = {
      enable = true;

      videoDrivers = [ "nvidia" ];

      xkb = {
        layout = "us";
        model = "pc105";
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
    pulseaudio.enable = false;

    gvfs.enable = true;
  };

  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
    enableRedistributableFirmware = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = { };
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
      xdg-desktop-portal-xapp
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts
      ubuntu-sans
      nerd-fonts.ubuntu-mono
      roboto
    ];

    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Ubuntu Mono" ];
      defaultFonts.sansSerif = [
        "Ubuntu Sans"
        "Noto Sans"
      ];
      defaultFonts.serif = [
        "Ubuntu Serif"
        "Noto Serif"
      ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

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
      libnotify
      wl-clipboard
      man-pages
      man-pages-posix
      dnsutils
      inetutils
      file
      tree

      xwayland-satellite
      swaybg
      waybar
    ];
  };

  documentation.dev.enable = true;

  programs = {
    wireshark.enable = true;
    dconf.enable = true;
    zsh.enable = true;
    nix-ld.enable = true;
    niri.enable = true;
  };

  powerManagement = {
    enable = true;
  };

  services.tlp.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
