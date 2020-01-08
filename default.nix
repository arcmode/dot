{ pkgs ? import <nixpkgs> {} }:

pkgs.callPackage ./nixpkgs/pkgs/dot.nix {}
