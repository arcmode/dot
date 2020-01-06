{ config, pkgs, lib ? pkgs.lib, ... }:

let
  cfg = config.programs.dot;
  dotPackage = (import ./. {});
in {
  options = {
    programs.dot = {
      enable = lib.mkEnableOption "dot";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ dotPackage ];
  };
}
