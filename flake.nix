{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };
  outputs = {nixpkgs, ...}: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = nixpkgs.legacyPackages.${system};
        });
    lib = nixpkgs.lib;
  in {
    packages = forEachSupportedSystem ({pkgs}: let
      hayase = pkgs.callPackage ./packages/hayase.nix {};
    in {
      df-pv = pkgs.callPackage ./packages/df-pv.nix {};
      miru = lib.warn "The 'miru' package is deprecated. Please use 'hayase' instead." hayase;
      hayase = hayase;
      helm-readme-generator = pkgs.callPackage ./packages/helm-readme-generator.nix {};
      tidb-tools = pkgs.callPackage ./packages/tidb-tools.nix {};
      okta-cli = pkgs.callPackage ./packages/okta-cli.nix {};
    });
    templates = import ./templates;
    overlays.default = final: prev: let
      hayase = final.callPackage ./packages/hayase.nix {};
    in {
      df-pv = final.callPackage ./packages/df-pv.nix {};
      miru = lib.warn "The 'miru' package is deprecated. Please use 'hayase' instead." hayase;
      hayase = hayase;
      helm-readme-generator = final.callPackage ./packages/helm-readme-generator.nix {};
      tidb-tools = final.callPackage ./packages/tidb-tools.nix {};
      okta-cli = final.callPackage ./packages/okta-cli.nix {};
    };
  };
}
