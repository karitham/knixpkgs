{
  description = "A flake of public packages ready to be used";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    rec
    {
      packages."${system}".miru = import ./miru.nix {
        stdenv = pkgs.stdenv;
        inherit pkgs;
      };
    };
}
