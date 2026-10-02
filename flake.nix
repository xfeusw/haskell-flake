{
  description = "Haskell flakes";

  outputs = { self }: {
    templates.default = {
      path = ./template;
      description = "Haskell flake with Haskell.nix";
      welcomeText = ''
        # Haskell flake

        Init:
          nix develop
          cabal init
      '';
    };
  };
}
