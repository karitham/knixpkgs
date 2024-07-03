{
  lib,
  autoPatchelfHook,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "tidb-tools";
  arch = "amd64";
  version = "v8.1.0";

  file = "tidb-community-toolkit-${version}-linux-${arch}";

  src = fetchurl {
    url = "https://download.pingcap.org/${file}.tar.gz";
    sha256 = "sha256-U/9+eUewaJARg0PAca0jaUlOtlWq307QoIaax8lTX9o=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  bins = [
    "binlogctl"
    "br"
    "cdc"
    "dm-master"
    "dm-worker"
    "dmctl"
    "drainer"
    "dumpling"
    "pd-recover"
    "pump"
    "reparo"
    "sync_diff_inspector"
    "tidb-lightning"
    "tidb-lightning-ctl"
  ];

  # It's a tarball of tarballs
  unpackPhase = ''
    tar -xzf $src -C ./
    for f in ./${file}/*.tar.gz; do
      tar -xzf $f -C ./
    done
  '';

  # Now that we have unpacked the tarballs, we can copy the binaries
  installPhase = ''
    mkdir -p $out/bin
    for bin in ${toString bins}; do
      find ./ -name $bin -exec cp {} $out/bin/ \;
    done
  '';

  meta = with lib; {
    description = "TiDB Community Toolkit";
    homepage = "https://github.com/pingcap/tidb";
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = with maintainers; [karitham];
  };
}
