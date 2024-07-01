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
    packages = forEachSupportedSystem ({...} @ inputs: {
      miru = import ./miru.nix inputs;
      helm-readme-generator = import ./helm-readme-generator.nix inputs;
      df-pv = import ./df-pv.nix inputs;
    });

    templates = {
      typst = {
        path =./typst;
        description = "typst";
      };
      k8s = {
        path =./k8s;
        description = "simple kubernetes ready env";
      };
    };
  };
}
