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
      perSystem = {pkgs, ...}: {
        devenv.shells.default = let
          haskell = pkgs.haskell.packages.ghc92.override {
            overrides = final: prev: {
              haskell-nix-template = prev.callPackage ./haskell-nix-template.nix {};
            };
          };

          hpackages = p: with p.haskell-nix-template.getCabalDeps; libraryHaskellDepends ++ executableHaskellDepends ++ testHaskellDepends;
          ghcCompiler = haskell.ghc.withHoogle hpackages;
        in {
          packages = [
            ghcCompiler
            pkgs.haskellPackages.cabal-install
            pkgs.cabal2nix
          ];
        };
      };
    };
}
