import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ...} : {

  name = "dot";

  nodes = {
    test = { config, pkgs, ... }: {
      imports = [ ./module.nix ];

      programs.dot.enable = true;
    };
  };

  testScript = ''
    startAll;

    $test->succeed('dot init "git@github.com:drojas/.files.git"')
  '';
})
