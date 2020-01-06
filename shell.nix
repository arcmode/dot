{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv
}:

let
  dotPackage = (import ./. {});
in
  stdenv.mkDerivation {
    name = "dot-env";
    buildInputs = [ dotPackage ];
  }
