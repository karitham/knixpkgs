{
  pkgs,
  lib,
  ...
}: let
  hayase = pkgs.callPackage ./hayase.nix {};
in {
  df-pv = pkgs.callPackage ./df-pv.nix {};
  miru = lib.warn "The 'miru' package is deprecated. Please use 'hayase' instead." hayase;
  hayase = hayase;
  helm-readme-generator = pkgs.callPackage ./helm-readme-generator.nix {};
  tidb-tools = pkgs.callPackage ./tidb-tools.nix {};
  okta-cli = pkgs.callPackage ./okta-cli.nix {};
}
