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
    rev = "b3061b82f0eaaa085be7204e2fd2a079112fc02b";
    sha256 = "4LY4fVJgE08z2iy/HN6qp1yVW88rmEYviJiwzmQe7Ns=";
  };
  buildInputs = [ bash subversion];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp nixhandle.sh $out/bin/nixhandle
    wrapProgram $out/bin/nixhandle \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}
  '';
}
