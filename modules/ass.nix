{ stdenv
, lib
, fetchFromGitHub
, bash
, subversion
, pkgs
, makeWrapper
}:

stdenv.mkDerivation {
  name = "nixhandle";
  src = fetchFromGitHub {
    owner = "ArkieSoft";
    repo = "ass";
    rev = "d99a48d19518b11be0ee19576709e520a88561be";
    sha256 = "gp+TAwmPxFY+eqlZPBu4iJT5mxxB3d4b8MVv7OJRKhE=";
  };
  buildInputs = [ bash subversion];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = if stdenv.isLinux then ''
    mkdir -p $out/bin
    ls
    cp nixhandle $out/bin/nixh
    wrapProgram $out/bin/nixh \
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

  '' else ''
    mkdir -p $out/bin
    cp nixhandle $out/bin/nixh
    wrapProgram $out/bin/nixh \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}
    '';
}
