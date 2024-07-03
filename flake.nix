{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    packages = forEachSupportedSystem ({...} @ inputs: let
      callPackage = inputs.pkgs.callPackage;
    in {
      miru = callPackage ./miru.nix {};
      helm-readme-generator = callPackage ./helm-readme-generator.nix {};
      df-pv = callPackage ./df-pv.nix {};
      tidb-tools = callPackage ./tidb-tools.nix {};
    });
    templates = {
      typst = {
        path = ./typst;
        description = "typst";
      };
      k8s = {
        path = ./k8s;
        description = "simple kubernetes ready env";
      };
    };
  };
}
