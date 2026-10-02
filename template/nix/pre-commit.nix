inputs:

system:
let
  treefmt = import ./treefmt.nix inputs system;
in
inputs.git-hooks.lib.${system}.run {
  src = ../.;

  hooks = {
    treefmt = {
      enable = true;
      package = treefmt.config.build.wrapper;
    };
  };
}
