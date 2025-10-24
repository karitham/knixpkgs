{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  makeWrapper,
  autoPatchelfHook,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  cairo,
  dbus,
  gtk3,
  libdrm,
  mesa,
  nspr,
  nss,
  cups,
}:
stdenv.mkDerivation rec {
  pname = "hayase";
  version = "6.4.34";

  src = fetchurl {
    url = "https://github.com/hayase-app/ui/releases/download/v${version}/linux-hayase-${version}-linux.deb";
    sha256 = "1zgxc978vd3pkfc4dqzppb6ff15gap9mcxq4zp2gd1wqm4wvyij8";
  };

  nativeBuildInputs = [dpkg makeWrapper autoPatchelfHook];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    cairo
    dbus
    gtk3
    libdrm
    mesa
    nspr
    nss
    cups
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out/bin $out/share
    cp -r opt/Hayase $out/share/hayase
    cp -r usr/share/* $out/share/

    # Patch the desktop file to use the correct binary path
    sed -i "s|/opt/Hayase/hayase|$out/bin/hayase|" $out/share/applications/*.desktop

    makeWrapper $out/share/hayase/hayase $out/bin/hayase \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
      --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland" \
      --set ELECTRON_NO_UPDATER 1
  '';

  meta = with lib; {
    description = "Anime torrent streaming app";
    homepage = "https://github.com/hayase-app/ui";
    license = licenses.bsl11;
    platforms = platforms.linux;
    maintainers = with maintainers; [karitham];
  };
}
