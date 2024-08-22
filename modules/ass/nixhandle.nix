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
    rev = "cc5a803921417e5e5cfff8e31bb9956052c116cf";
    sha256 = "L8ODHFGaa4vAFteOIY1PP625KZX4cB7lUB83sa/ex8I=";
  };
  buildInputs = [ bash subversion];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    ls
    cp nixhandle $out/bin/nixhandle
    wrapProgram $out/bin/nixhandle \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp autostart $out/bin/autostart
    wrapProgram $out/bin/autostart \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp brb $out/bin/brb
    wrapProgram $out/bin/brb \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp dance $out/bin/dance
    wrapProgram $out/bin/dance \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp hydro $out/bin/hydro
    wrapProgram $out/bin/hydro \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp swwwchange $out/bin/swwwchange
    wrapProgram $out/bin/swwwchange \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp tbc $out/bin/tbc
    wrapProgram $out/bin/tbc \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp toggle $out/bin/toggle
    wrapProgram $out/bin/toggle \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

  '';
}
