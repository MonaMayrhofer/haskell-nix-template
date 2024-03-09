# Haskell Nix Template

Opinonated Template for haskell development using nix.

## Dependencies

Use [project-name].cabal to track project dependencies, then Use
`cabal2nix . > [project-name].nix` to generate the nix expression.
You might wanna rebuild the shell (e.g via `direnv reload`) to actually
install the dependencies and make them available to cabal.

Nix

## Shell

Use direnv or simply `nix develop --impure` to activate the shell (which is based on devenv).
The shell contains all the dependencies from the `[project-name].nix` file, which was in turn generated
from the `[project-name].cabal` file.

## Tests

Run tests using `cabal test --test-options="--color always"`, if all tests pass cabal will hide the output.
