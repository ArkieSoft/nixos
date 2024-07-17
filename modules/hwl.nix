{ lib
, fetchFromGitHub
, pkg-config
, pixman
, libdrm
, hyprland
, hyprlandPlugins
,
}:
hyprlandPlugins.mkHyprlandPlugin hyprland {
  pluginName = "hyprWorkspaceLayouts";
  version = "0.39.1";

  src = fetchFromGitHub {
    owner = "ArkieSoft";
    repo = "hyprWorkspaceLayouts";
    rev = "1.0.0";
    hash = "sha256-5JUhPYnWyIEKBHezTv9Dc0bjepMtJi6ScJWTIrVrpkg=";
  };

  nativeBuildInputs = [ ];

  buildPhase = ''
    export HOME=$(pwd)
    #make all 
  '';

  # sourceRoot = ".";

  meta = {
    homepage = "https://github.com/zakk4223/hyprWorkspaceLayouts/tree/main";
    description = "Per Workspace Layouts";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
  };
}
