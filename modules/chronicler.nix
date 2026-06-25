{ stdenv
, fetchurl
, dpkg
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "Chronicler";
  version = "0.53.0-alpha";

  src = fetchurl {
    url = "https://example.com/myapp_${version}_amd64.deb";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out/
  '';

  meta = {
    description = "My application packaged from a Debian package";
    platforms = [ "x86_64-linux" ];
  };
}
