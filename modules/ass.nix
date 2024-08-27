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
    rev = "d8daa99448b0a61e6650e8a3e2f4f50b54c11e95";
    sha256 = "DSV4faBOCTzx4JkwJSRagEAiSEcdSr8V4R1gyF9zNW0=";
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
    
    cp brb $out/bin/brb
    wrapProgram $out/bin/brb \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp dance $out/bin/dance
    wrapProgram $out/bin/dance \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

     cp tbc $out/bin/tbc
    wrapProgram $out/bin/tbc \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}
  
    cp toggle $out/bin/toggle
    wrapProgram $out/bin/toggle \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

    cp hydro $out/bin/hydro
    wrapProgram $out/bin/hydro \
      --prefix PATH : ${lib.makeBinPath [ bash subversion ]}


  
  '';
}
