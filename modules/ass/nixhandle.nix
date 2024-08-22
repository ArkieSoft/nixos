{ stdenv
, lib
, fetchFromGitHub
, bash
, subversion
, makeWrapper
}:

stdenv.mkDerivation {
  name = "nixhandle";
  src = fetchFromGitHub {
    owner = "ArkieSoft";
    repo = "ass";
    rev = "fd02f57b28c35c6f79e6936ba9cf88ddf2356cc5";
    sha256 = "BxJJnr/vQluce0WCxLhjfXjudd7tR/yqb11/GZk+WTs=";
  };
  buildInputs = [ bash subversion];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    ls
    cp nixhandle $out/bin/nixhandle
    wrapProgram $out/bin/nixhandle \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}
  '';
}
