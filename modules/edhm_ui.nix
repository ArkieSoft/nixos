{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, makeDesktopItem
, makeWrapper
, unzip
, gtk3
, glib
, cairo
, pango
, nss
, nspr
, mesa
, libdrm
, alsa-lib
, dbus
, cups
, expat
, at-spi2-atk
, at-spi2-core
, xorg
}:

stdenv.mkDerivation rec {
  pname = "edhm-ui";
  version = "3.0.61";

  src = fetchurl {
    url = "https://github.com/BlueMystical/EDHM_UI/releases/download/v${version}/edhm-ui-v3-linux-x64.zip";
    sha256 = "sha256-TPatLTHQTAn2M6OAogoaoXyMJogF8SNZ/vPBdINIK8A=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    unzip
    makeWrapper
  ];

  buildInputs = [
    gtk3
    glib
    cairo
    pango
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXext
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    nss
    nspr
    mesa
    libdrm
    alsa-lib
    dbus
    cups
    expat
    at-spi2-atk
    at-spi2-core
  ];

  desktopItem = makeDesktopItem {
    name = "edhm-ui";
    desktopName = "EDHM UI";
    exec = "edhm-ui";
    icon = "edhm-ui";
    categories = [ "Game" "Utility" ];
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/edhm-ui
    mkdir -p $out/share/icons/hicolor/256x256/apps
    mkdir -p $out/share/applications

    cp -r . $out/share/edhm-ui
    chmod +x $out/share/edhm-ui/edhm-ui-v3
    wrapProgram $out/share/edhm-ui/edhm-ui-v3 \
      --set ELECTRON_DISABLE_SANDBOX 1

    ln -s $out/share/edhm-ui/edhm-ui-v3 $out/bin/edhm-ui
    cp resources/images/icon.png \
      $out/share/icons/hicolor/256x256/apps/edhm-ui.png

    runHook postInstall
  '';

  meta = with lib; {
    description = "Elite Dangerous HUD Mod UI";
    homepage = "https://github.com/BlueMystical/EDHM_UI";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}

