{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
  };
  outputs = {nixpkgs, ...}: {
    devShell = nixpkgs.lib.genAttrs ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"] (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            kubernetes-helm
            kubectx
            kubectl
            kind
            fluxcd
            sops
          ];
        }
    );
  };
}
