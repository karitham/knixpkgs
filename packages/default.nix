{
  callPackage,
  lib,
  ...
}: let
  hayase = callPackage ./hayase.nix {};
in {
  df-pv = callPackage ./df-pv.nix {};
  miru = lib.warn "The 'miru' package is deprecated. Please use 'hayase' instead." hayase;
  hayase = hayase;
  helm-readme-generator = callPackage ./helm-readme-generator.nix {};
  tidb-tools = callPackage ./tidb-tools.nix {};
  okta-cli = callPackage ./okta-cli.nix {};
}
