{pkgs}:
pkgs.buildNpmPackage {
  pname = "helm-readme-generator";
  version = "2.6.1";

  src = pkgs.fetchFromGitHub {
    owner = "bitnami";
    repo = "readme-generator-for-helm";
    rev = "2.6.1";
    sha256 = "sha256-hgVSiYOM33MMxVlt36aEc0uBWIG/OS0l7X7ZYNESO6A=";
  };

  npmDepsHash = "sha256-baRBchp4dBruLg0DoGq7GsgqXkI/mBBDowtAljC2Ckk=";
  dontNpmBuild = true;

  meta = with pkgs.lib; {
    name = "helm-readme-generator";
    description = "Auto generate READMEs for Helm Charts";
    homepage = "https://github.com/bitnami/readme-generator-for-helm";
    license = licenses.asl20;
    maintainers = with maintainers; [karitham];
    platforms = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    mainProgram = "readme-generator";
  };
}
