inputs:

system:
let
  pkgs = inputs.nixpkgs.legacyPackages.${system};

  project = import ./project.nix inputs system;
  pre-commit = import ./pre-commit.nix inputs system;
in
project.shellFor {
  tools = {
    cabal = "latest";
    fourmolu = "latest";
    hlint = "latest";
    ghcid = "latest";
    haskell-language-server = "latest";
    implicit-hie = "latest";
  };

  buildInputs = with pkgs; [
    cabal-install

    pkg-config

    zlib
    zlib.dev

    bzip2
    bzip2.dev

    libzip

    libpq
    libpq.dev

    nixd
    statix
    deadnix

    jq
    just
  ];

  shellHook = ''
    ${pre-commit.shellHook}

    export LD_LIBRARY_PATH="${
      pkgs.lib.makeLibraryPath [
        pkgs.postgresql
        pkgs.libzip
        pkgs.bzip2
      ]
    }:$LD_LIBRARY_PATH"

    export LIBRARY_PATH="${
      pkgs.lib.makeLibraryPath [
        pkgs.bzip2
      ]
    }:$LIBRARY_PATH"
  '';
}
