import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ...} : {

  name = "dot-test";

  nodes = {
    test = { config, pkgs, ... }: {
      imports = [ ../modules/programs/dot.nix ];

      programs.dot.enable = true;
    };
  };

  testScript =
    ''
      startAll;

      $test->waitForUnit("multi-user.target");

      $test->succeed("which dot");
    '';
})
