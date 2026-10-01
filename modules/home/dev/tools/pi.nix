{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  options.dev.tools.pi = {
    enable = lib.mkEnableOption "Pi coding agent";
  };

  config = lib.mkIf config.dev.tools.pi.enable {
    home.packages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
    ];
  };
}
