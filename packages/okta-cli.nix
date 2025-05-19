{
  pkgs,
  stdenv,
  autoPatchelfHook,
  zlib,
  ...
}:
stdenv.mkDerivation rec {
  pname = "okta-cli";
  name = "okta";
  version = "0.10.0";
  src = pkgs.fetchzip {
    url = "https://github.com/okta/okta-cli/releases/download/okta-cli-tools-0.10.0/okta-cli-linux-${version}-x86_64.zip";
    hash = "sha256-U5XeoQqAxFw0DmWv815T01RNehjdNwHDkvl0eRBoLjQ=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    zlib
  ];

  installPhase = ''
    runHook preInstall
    install -m755 -D ${name} $out/bin/${name}
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Okta CLI";
    homepage = "https://github.com/okta/okta-cli";
    mainProgram = name;
    license = licenses.asl20;
    maintainers = with maintainers; [karitham];
  };
}
