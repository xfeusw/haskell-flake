inputs:

system:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ inputs.haskellNix.overlay ];
  };
in
pkgs.haskell-nix.cabalProject' {
  src = pkgs.haskell-nix.haskellLib.cleanGit {
    src = ../.;
  };

  compiler-nix-name = "ghc912";
}
