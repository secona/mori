{...}: {
  imports = [./../../modules/home];

  programs.home-manager.enable = true;

  desktop = {
    wms = {
      sway.enable = true;
    };

    ui = {
      catppuccin.enable = true;
    };

    apps = {
      terminals = {
        kitty.enable = true;
      };

      browsers = {
        google-chrome.enable = true;
      };

      socials = {
        discord.enable = true;
        zoom-us.enable = true;
      };

      docs = {
        libreoffice.enable = true;
        xournalpp.enable = true;
        zathura.enable = true;
      };

      media = {
        vlc.enable = true;
        miru.enable = true;
      };

      misc = {
        octave.enable = true;
        jflap.enable = true;
      };
    };

    games = {
      minecraft.enable = true;
    };
  };

  cli = {
    shells = {
      zsh.enable = true;
    };

    tools = {
      bat.enable = true;
      btop.enable = true;
      eza.enable = true;
      gh-dash.enable = true;
      starship.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      zoxide.enable = true;
    };
  };

  dev = {
    editors = {
      nvim.enable = true;
      idea-ultimate.enable = true;
      vscode.enable = true;
    };

    tools = {
      direnv.enable = true;
      lazygit.enable = true;
      postman.enable = true;

      git.userName = "secona";
      git.userEmail = "77039267+secona@users.noreply.github.com";
      git.enable = true;
    };
  };

  home = {
    username = "secona";
    homeDirectory = "/home/secona";
    stateVersion = "24.05";
  };
}
