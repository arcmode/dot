{
  pkgs ? (import <nixpkgs> {})
}:

with pkgs;

let
  gitPath = lib.makeBinPath [ git ];
in
stdenv.mkDerivation rec {
  pname = "dot";
  version = "0.0.0";
  meta = with stdenv.lib; {
    description = "Simple dotfiles management in bash with git";
    homepage = https://github.com/drojas/dot;
    license = licenses.gpl3;
    maintainers = [
      "David Rojas Camaggi - drojascamaggi@gmail.com"
    ];
    platforms = platforms.all;
  };
  phases = "installPhase fixupPhase";
  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/dot.bash $out/.wrapped
    chmod +x $out/.wrapped
    makeWrapper $out/.wrapped $out/bin/dot --prefix PATH : ${ gitPath }
  '';
  # TODO: what is the simplest approach in order to fetchFromGitHub instead (same repo vs git subtree)
  src = ../../src;
  nativeBuildInputs = [ makeWrapper ];
}
