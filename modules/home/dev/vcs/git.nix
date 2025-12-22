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
      package = pkgs.gitFull;

      settings = {
        user.name = config.dev.vcs.git.userName;
        user.email = config.dev.vcs.git.userEmail;
        aliases = {
          a = "add";
          c = "commit";
        };
      };
    };
  };
}
