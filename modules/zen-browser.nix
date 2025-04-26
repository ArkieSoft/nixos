{ stdenv, pkgs, lib, buildNpmPackage, fetchFromGitHub }:
buildNpmPackage rec {
    name = "zen-browser";
    version = "1.7.6b";

    src = fetchFromGitHub {
      owner = "zen-browser";
      repo = "desktop";
      rev = "1.7.6b";
      hash = "sha256-gKma7onLk5XIZARCELVvRUwGXOhwzN1wRDiP3I6mcow=";
      fetchSubmodules = true;
    };

  npmDepsHash = "sha256-jPcig+8Z4gREAwmRqTsKsnY/ATGMXI7Ta0YezCNxAfg=";

  meta = with lib; {
    description = "Zen Browser";
    homepage = "https://zen-browser.app/";
    license = licenses.mpl20;
  };
}
