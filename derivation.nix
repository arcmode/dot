{
  pkgs ? (import <nixpkgs> {}),
  stdenv ? pkgs.stdenv,
}:

let
  gitPath = pkgs.lib.makeBinPath [ pkgs.git ];
in
stdenv.mkDerivation rec {
  pname = "dot";
  version = "0.0.0";
  meta = with stdenv.lib; {
    description = "Minimal dotfiles manager in bash with git";
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
    cp ${src}/dot.bash $out/bin/dot
    chmod +x $out/bin/dot
    wrapProgram $out/bin/dot --prefix PATH : ${ gitPath }
  '';
  src = ./src;
  nativeBuildInputs = [ pkgs.makeWrapper ];
}
