inputs:

system:
inputs.treefmt-nix.lib.evalModule inputs.nixpkgs.legacyPackages.${system} {
  projectRootFile = "flake.nix";

  programs.fourmolu.enable = true;
  programs.cabal-fmt.enable = true;
  programs.nixfmt.enable = true;
}
