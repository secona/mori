{pkgs, lib, config, ...}: {
  options.dev.postman = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.dev.postman.enable {
    home.packages = [pkgs.postman];
  };
}
