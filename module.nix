{ config, pkgs, lib ? pkgs.lib, ... }:

with lib;

let
  cfg = config.programs.dot;
  dotPackage = (import ./. {});
in {
  options = {
    programs.dot = {
      enable = mkEnableOption "dot";
      pkg = mkOption {
        type = types.package;
        default = dotPackage;
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ dotPackage ];
  };
}
