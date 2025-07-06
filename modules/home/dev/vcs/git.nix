{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.vcs.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    userName = lib.mkOption {
      type = lib.types.str;
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.dev.vcs.git.enable {
    home.shellAliases = {
      g = "git";
    };

    programs.git = {
      enable = true;
      userName = config.dev.vcs.git.userName;
      userEmail = config.dev.vcs.git.userEmail;
      package = pkgs.gitFull;

      aliases = {
        a = "add";
        c = "commit";
      };
    };
  };
}
