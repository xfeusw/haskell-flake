{
  description = "Haskell template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    haskellNix = {
      url = "github:input-output-hk/haskell.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs) nixpkgs systems;

      eachSystem = nixpkgs.lib.genAttrs (import systems);

      project = import ./nix/project.nix inputs;
      treefmt = import ./nix/treefmt.nix inputs;
      devShell = import ./nix/shell.nix inputs;
      checks = import ./nix/checks.nix inputs;
    in
    {
      packages = eachSystem (system: {
        default = project system;
      });

      devShells = eachSystem (system: {
        default = devShell system;
      });

      formatter = eachSystem (system: treefmt system);

      checks = eachSystem (system: checks system);
    };
}
