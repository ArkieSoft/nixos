{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      bitstruct
      cython
      hid
      hidapi
      watchdog
      pyinstaller
      pyqt6
      pip
      pywayland
      pydbus
    ]))
  ];
}
