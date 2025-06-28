{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.tools.jujutsu = {
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

  config = lib.mkIf config.dev.tools.jujutsu.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user.name = config.dev.tools.jujutsu.userName;
        user.email = config.dev.tools.jujutsu.userEmail;
      };
    };
  };
}
