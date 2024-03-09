{
  description = "my project description";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      imports = [
        inputs.devenv.flakeModule
      ];
      perSystem = {pkgs, ...}: let
        haskell = pkgs.haskell.packages.ghc92.override {
          overrides = _: prev: {
            haskell-nix-template = prev.callPackage ./haskell-nix-template.nix {};
          };
        };
      in {
        packages.default = haskell.haskell-nix-template;

        devenv.shells.default = let
          hpackages = p: with p.haskell-nix-template.getCabalDeps; libraryHaskellDepends ++ executableHaskellDepends ++ testHaskellDepends;
          ghcCompiler = haskell.ghc.withHoogle hpackages;
        in {
          packages = [
            pkgs.cabal2nix
          ];

          processes = {
            hoogle.exec = "hoogle server --local -p 9090";
          };

          languages.haskell = {
            enable = true;
            package = ghcCompiler;
            stack = null;
          };
        };
      };
    };
}
