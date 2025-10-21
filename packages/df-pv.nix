{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "df-pv";
  name = "df-pv";
  version = "v0.3.0";
  src = fetchFromGitHub {
    owner = "yashbhutwala";
    repo = "kubectl-df-pv";
    rev = "${version}";
    sha256 = "sha256-FxKqkxLMNfCXuahKTMod6kWKZ/ucYeIEFcS8BmpbLWg=";
  };
  vendorHash = "sha256-YkDPgN7jBvYveiyU8N+3Ia52SEmlzC0TGBQjUuIAaw0=";
}
