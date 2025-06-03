{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.tools.git = {
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

  config = lib.mkIf config.dev.tools.git.enable {
    programs.git = {
      enable = true;
      userName = config.dev.tools.git.userName;
      userEmail = config.dev.tools.git.userEmail;
      package = pkgs.gitFull;
    };
  };
}
