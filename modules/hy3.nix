{ pkgs, ... }: {
  hy3 = pkgs.callPackage ({ lib
                          , fetchFromGitHub
                          , cmake
                          , hyprland
                          , hyprlandPlugins
                          ,
                          }:
    hyprlandPlugins.mkHyprlandPlugin pkgs.hyprland {
      pluginName = "hy3";
      version = "0.39.1";

      src = fetchFromGitHub {
        owner = "outfoxxed";
        repo = "hy3";
        rev = "hl0.39.1";
        hash = "sha256-PqVld+oFziSt7VZTNBomPyboaMEAIkerPQFwNJL/Wjw=";
      };

      # any nativeBuildInputs required for the plugin
      nativeBuildInputs = [ cmake ];

      # set any buildInputs that are not already included in Hyprland
      # by default, Hyprland and its dependencies are included
      buildInputs = [ ];

      meta = {
        homepage = "https://github.com/outfoxxed/hy3";
        description = "Hyprland plugin for an i3 / sway like manual tiling layout";
        license = lib.licenses.gpl3;
        platforms = lib.platforms.linux;
        maintainers = with lib.maintainers; [ aacebedo ];
      };
    });
}
