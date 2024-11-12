{pkgs, lib, config, ...}: {
  options.apps.xournalpp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.xournalpp.enable {
    home.packages = [pkgs.xournalpp];
  };
}
