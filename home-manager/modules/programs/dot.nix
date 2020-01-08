{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.dot;
  dotPackage = (import ../../../. {});
in {
  options = {
    programs.dot = {
      enable = mkEnableOption "dot";
      package = mkOption {
        type = types.package;
        default = dotPackage;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
