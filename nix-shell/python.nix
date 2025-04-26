let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/cdd2ef009676ac92b715ff26630164bb88fec4e0.tar.gz") {};
in pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      pytermgui
    ]))
  ];
}
