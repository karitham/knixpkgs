{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        tfmt = pkgs.writeShellScriptBin "tfmt" ''
          if [ -z "$1" ]; then
            echo "Usage: fmt <file>"
            exit 1
          fi

          # line wrapping
          ${pkgs.typstfmt}/bin/typstfmt "$@"

          # better formatting
          ${pkgs.typstyle}/bin/typstyle -i -- "$@"
        '';
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            typst
            typst-lsp
            typst-preview
            tfmt
          ];
        };
      }
    );
}
