{ mkDerivation, base, lib, tasty, tasty-hunit, text, text-ansi }:
mkDerivation {
  pname = "haskell-nix-template";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base text text-ansi ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [ base tasty tasty-hunit ];
  license = lib.licenses.mit;
  mainProgram = "haskell-nix-template";
}
