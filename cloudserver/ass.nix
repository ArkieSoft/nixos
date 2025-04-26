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
    rev = "d9b5006661ee729a2b9deb81602cf66ae6957fc4";
    sha256 = "sha256-NFR8Ilryxl23MgREw4NnxSWrbgjArEEDQjURIAStoOw=";
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
