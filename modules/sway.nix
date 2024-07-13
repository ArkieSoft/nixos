{ lib, config, pkgs, ... }:
{
  wayland.windowManager.sway =
    {
      enable = true;
      #package = pkgs.swayfx-unwrapped;
      xwayland = true;
      config = {
        modifier = "Mod4";
        fonts = {
          names = [ "Caskaydia Cove" ];
          style = "Regular";
          size = 10.0;
        };
        workspaceLayout = "default";
        gaps = {
          inner = 6;
          outer = 3;
        };
        floating = {
          modifier = "Mod4";
        };
        keybindings =
          let
            modifier = config.wayland.windowManager.sway.config.modifier;
          in
          lib.mkOptionDefault {
            "${modifier}+Return" = "exec kitty";
            "${modifier}+Tab" = "workspace next";
            "${modifier}+Shift+Tab" = "workspace prev";
            "${modifier}+1" = "workspace 1";
            "${modifier}+2" = "workspace 2";
            "${modifier}+3" = "workspace 3";
            "${modifier}+4" = "workspace 4";
            "${modifier}+5" = "workspace 5";
            "${modifier}+6" = "workspace 6";
            "${modifier}+7" = "workspace 7";
            "${modifier}+8" = "workspace 8";
            "${modifier}+9" = "workspace 9";
            "${modifier}+0" = "workspace 10";
            "${modifier}+Shift+1" = "move container to workspace 1";
            "${modifier}+Shift+2" = "move container to workspace 2";
            "${modifier}+Shift+3" = "move container to workspace 3";
            "${modifier}+Shift+4" = "move container to workspace 4";
            "${modifier}+Shift+5" = "move container to workspace 5";
            "${modifier}+Shift+6" = "move container to workspace 6";
            "${modifier}+Shift+7" = "move container to workspace 7";
            "${modifier}+Shift+8" = "move container to workspace 8";
            "${modifier}+Shift+9" = "move container to workspace 9";
            "${modifier}+Shift+0" = "move container to workspace 10";
            "${modifier}+q" = "kill";
            "${modifier}+Shift+r" = "reload";
            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";
            "Ctrl+Left" = "move left";
            "Ctrl+Down" = "move down";
            "Ctrl+Up" = "move up";
            "Ctrl+Right" = "move right";
            "${modifier}+h" = "split h";
            "${modifier}+b" = "split v";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+v" = "floating toggle";
            "${modifier}+w" = "exec firefox";
            "${modifier}+d" = "exec rofi -show drun -config /etc/nixos/rofidmenu.rasi";
            "${modifier}+s" = "exec grimblast --freeze copysave area";
          };
        workspaceOutputAssign = [
          { workspace = "1"; output = "DP-2"; }
          { workspace = "2"; output = "DP-1"; }
          { workspace = "3"; output = "HDMI-A-1"; }
          { workspace = "4"; output = "DP-2"; }
          { workspace = "5"; output = "DP-1"; }
          { workspace = "6"; output = "DP-1"; }
        ];
        terminal = "alacritty";
        startup = [
          { command = "/etc/nixos/swwwchange.sh /etc/nixos/wallpapers"; }
          { command = "systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service"; }
          { command = "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"; }
          { command = "swaymsg output HDMI-A-1 mode 1920x1080 position 2560 0"; always = true; }
          { command = "swaymsg output DP-1 mode 2560x1440 position 2560 1080"; always = true; }
          { command = "swaymsg output DP-2 mode 2560x1440 position 0 1080"; always = true; }
        ];
        window = {
          titlebar = false;
        };
        floating.titlebar = false;
        colors =
          let
            darkblue = "#08052b";
            lightblue = "#5294e2";
            urgentred = "#e53935";
            white = "#ffffff";
            black = "#000000";
            purple = "#e345ff";
            darkgrey = "#383c4a";
            grey = "#b0b5bd";
            mediumgrey = "8b8b8b";
            yellowbrown = "e1b700";
          in
          {
            focused = {
              background = darkblue;
              border = lightblue;
              childBorder = mediumgrey;
              text = white;
              indicator = mediumgrey;
            };
            unfocused = {
              background = darkblue;
              border = darkblue;
              childBorder = darkgrey;
              text = grey;
              indicator = darkgrey;
            };
            focusedInactive = {
              background = darkblue;
              border = darkblue;
              childBorder = black;
              text = grey;
              indicator = black;
            };
            urgent = {
              background = urgentred;
              border = urgentred;
              childBorder = yellowbrown;
              text = white;
              indicator = yellowbrown;
            };
          };
        bars =
          let
            darkblue = "#08052b";
            lightblue = "#5294e2";
            urgentred = "#e53935";
            white = "#ffffff";
            black = "#000000";
            purple = "#e345ff";
            darkgrey = "#383c4a";
            grey = "#b0b5bd";
            mediumgrey = "8b8b8b";
            yellowbrown = "e1b700";
          in
          [{
            workspaceButtons = true;
            workspaceNumbers = true;
            position = "top";
            trayPadding = 0;
            fonts = {
              names = [ "Caskaydia Cove" ];
              style = "Regular";
              size = 10.0;
            };
            colors = {
              background = darkgrey;
              separator = purple;
              statusline = white;
              activeWorkspace = {
                background = mediumgrey;
                border = lightblue;
                text = darkgrey;
              };
              inactiveWorkspace = {
                background = darkgrey;
                border = darkgrey;
                text = grey;
              };
              urgentWorkspace = {
                background = urgentred;
                border = urgentred;
                text = white;
              };
              focusedWorkspace = {
                background = grey;
                border = mediumgrey;
                text = darkgrey;
              };
            };
          }];
      };
    };
}
