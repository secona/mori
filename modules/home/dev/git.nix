{
  pkgs,
  lib,
  config,
  ...
}: {
  options.dev.git = {
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

  config = lib.mkIf config.dev.git.enable {
    programs.git = {
      enable = true;
      userName = config.dev.git.userName;
      userEmail = config.dev.git.userEmail;
      package = pkgs.gitFull;
    };
  };
}
