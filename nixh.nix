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
    rev = "aa31c8e39ab6ca201e6b00633d30aea97ba240e9";
    sha256 = "sha256-Kw76LoqcMfCjZqHDpNqBwwMyrrP+oILkZtqvIH1FwJ4=";
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

    '' else ''
      mkdir -p $out/bin
      cp nixhandle $out/bin/nixh
      wrapProgram $out/bin/nixh \
        --prefix PATH : ${lib.makeBinPath [ bash subversion ]}
    '';
}
