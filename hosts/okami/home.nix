{ ... }:
{
  imports = [ ./../../modules/home ];

  programs.home-manager.enable = true;

  desktop = {
    wms = {
      sway.enable = true;
    };

    ui = {
      catppuccin.enable = true;
    };

    terminals = {
      kitty.enable = true;
    };

    browsers = {
      google-chrome.enable = true;
    };

    socials = {
      discord.enable = true;
      zoom-us.enable = false;
    };

    docs = {
      libreoffice.enable = true;
      xournalpp.enable = true;
      zathura.enable = true;
    };

    media = {
      vlc.enable = true;
      obs-studio.enable = true;
      miru.enable = true;
    };

    misc = {
      anki.enable = true;
      octave.enable = false;
      jflap.enable = false;
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
      gh-dash.enable = true;
      lazygit.enable = true;
      postman.enable = true;
      wireshark.enable = false;
    };

    vcs = let
      userName = "secona";
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

  home = {
    username = "secona";
    homeDirectory = "/home/secona";
    stateVersion = "24.05";
  };
}
