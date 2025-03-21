{pkgs, ...}: {
  df-pv = pkgs.callPackage ./df-pv.nix {};
  miru = pkgs.callPackage ./miru.nix {};
  helm-readme-generator = pkgs.callPackage ./helm-readme-generator.nix {};
  tidb-tools = pkgs.callPackage ./tidb-tools.nix {};
}
