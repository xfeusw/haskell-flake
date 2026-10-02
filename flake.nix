{
  description = "Haskell flakes";

  outputs = { self }: {
    templates.default = {
      path = ./template;
      description = "Haskell flake with Haskell.nix";
      welcomeText = ''
        # Haskell project

        Initialize the Cabal package:

          cabal init

        Then enter the development shell:

          nix develop
      '';
    };
  };
}
