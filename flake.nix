{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  description = "miru";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      stdenv = pkgs.stdenv;
    in
    rec
    {
      version = "4.5.9";

      miru = pkgs.appimageTools.wrapType2 {
        name = "miru";
        src = pkgs.fetchurl {
          url = "https://github.com/ThaUnknown/miru/releases/download/v${version}/linux-Miru-${version}.AppImage";
          hash = "sha256-Ntziq6MFkw4nif9jKifmkXjhHVcwgy+9ckqDXkoYG5M=";
        };
        extraPkgs = pkgs: with pkgs; [ ];

        meta = with stdenv.lib; {
          name = "miru";
          description = "Bittorrent streaming software for cats.";
          homepage = "https://github.com/ThaUnknown/miru";
          platform = [ system ];
          targetPkgs = [ miru ];
          mainProgram = "miru";
        };
      };

      packages."${system}".miru = miru;
    };
}
