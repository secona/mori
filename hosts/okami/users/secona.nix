{ pkgs, ... }:
{
  users.users.secona = {
    shell = pkgs.nushell;
    isNormalUser = true;
    description = "secona";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "wireshark"
      "dialout"
    ];
  };

  home-manager.users.secona = {
    imports = [ ./../../../modules/home ];

    programs.home-manager.enable = true;

    home = {
      username = "secona";
      homeDirectory = "/home/secona";
      stateVersion = "24.05";

      shellAliases = {
        l = "ls -al";
        ll = "ls -al";
        la = "ls -a";
      };
    };

    desktop = {
      wms = {
        sway.enable = true;
      };

      ui = {
        gtk.enable = true;
        catppuccin.enable = true;
      };

      terminals = {
        kitty.enable = true;
        ghostty.enable = true;
      };

      browsers = {
        firefox.enable = true;
        google-chrome.enable = true;
      };

      socials = {
        discord.enable = true;
      };

      docs = {
        libreoffice.enable = true;
        xournalpp.enable = true;
        zathura.enable = true;
      };

      media = {
        vlc.enable = true;
        obs-studio.enable = true;
      };

      misc = {
        cisco-packet-tracer.enable = true;
      };

      games = {
        minecraft.enable = true;
      };
    };

    cli = {
      shells = {
        nushell.enable = true;
        zsh.enable = true;
      };

      monitoring = {
        btop.enable = true;
      };

      tools = {
        bat.enable = true;
        carapace.enable = true;
        eza.enable = true;
        starship.enable = true;
        tmux.enable = true;
        yazi.enable = true;
        zellij.enable = true;
        zoxide.enable = true;
      };
    };

    dev = {
      editors = {
        nvim.enable = true;
        cursor.enable = true;
        idea-ultimate.enable = false;
        vscode.enable = true;
        zed-editor.enable = true;
      };

      tools =  {
        burpsuite.enable = false;
        devenv.enable = true;
        direnv.enable = true;
        gemini-cli.enable = true;
        gh-dash.enable = true;
        lazygit.enable = true;
        postman.enable = true;
        wireshark.enable = true;
      };

      vcs = let
        userName = "Vito Secona";
        userEmail = "secona00@gmail.com";
      in {
        git = {
          enable = true;
          inherit userName userEmail;
        };

        jujutsu = {
          enable = true;
          inherit userName userEmail;
        };
      };
    };
  };
}
