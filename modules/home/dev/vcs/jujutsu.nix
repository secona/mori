{
  lib,
  config,
  ...
}:
{
  options.dev.vcs.jujutsu = {
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

  config = lib.mkIf config.dev.vcs.jujutsu.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user.name = config.dev.vcs.jujutsu.userName;
        user.email = config.dev.vcs.jujutsu.userEmail;
      };
    };
  };
}
