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
    rev = "b6f2b6c37b2548a1eefa19881af3e427dcb7e737";
    sha256 = "sha256-0hGxa5OtPMHvm/y/IGs4+zBzj3PK/ZLNUg3leJiAzMk=";
  };
  buildInputs = [ bash subversion ];
  nativeBuildInputs = [ makeWrapper ];
  installPhase =
    if stdenv.isLinux then ''
      mkdir -p $out/bin
      ls
      cp nixhandle $out/bin/nixh
      wrapProgram $out/bin/nixh \
        --prefix PATH : ${lib.makeBinPath [ bash subversion ]}
     
      cp restart $out/bin/restart
      wrapProgram $out/bin/restart \
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
