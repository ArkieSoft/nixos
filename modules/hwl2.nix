{ pkgs, ... }: {
  hyprWorkspaceLayouts = pkgs.callPackage ({ lib
                                           , fetchFromGitHub
                                           , cmake
                                           , hyprland
                                           , hyprlandPlugins
                                           ,
                                           }:
    hyprlandPlugins.mkHyprlandPlugin pkgs.hyprland {
      pluginName = "hyprWorkspaceLayouts";
      version = "0.39.1";

      src = fetchFromGitHub {
        owner = "zakk4223";
        repo = "hyprWorkspaceLayouts";
        rev = "1.0.0";
        hash = "sha256=1yzwma2fzs1w4fyg5nvsbv7sy74pa1ap6hng2ydz7cys7mj0yc8d";
      };

      nativeBuildInputs = [ cmake ];

      meta = {
        homepage = "https://github.com/zakk4223/hyprWorkspaceLayouts/tree/main";
        description = "Per Workspace Layouts";
        license = lib.license.bsd3;
        platforms = lib.platforms.linux;
      };
    });
}
