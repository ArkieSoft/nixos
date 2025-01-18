{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland =
    {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        exec-once = [
          "swwwchange /etc/nixos/wallpapers"
          "autostart"
          "hyprctl setcursor Bibata-Modern-Classic 24"
          "systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service"
          "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
          "hyprctl dispatch exec [workspace 3 silent] vesktop"
          "hyprctl dispatch exec [workspace 6 silent] thunderbird"
          "hyprctl dispatch exec [workspace 6 silent] signal-desktop"
# "hyprctl dispatch exec [workspace 6 silent] kitty gomuks"
          "hyprctl dispatch exec [workspace 6 silent] pavucontrol"
          "hyprctl dispatch exec [workspace 6 silent] telegram-desktop"
          "hyprctl dispatch -- exec [workspace 7 silent] obs --studio-mode --startvirtualcam --disable-shutdown-check"
        ];

        input = {
          kb_layout = "us";
        };

        general = {
          #gaps_in = 5;
          gaps_in = 0;
          #gaps_out = 10;
          gaps_out = 0;
          border_size = 3;
          #"col.active_border" = "rgba(ff99e694) rgba(869ef4cf) 45deg";
          "col.active_border" = "rgba(FF7F50FF) rgba(00FFFFFF) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "master";
        };

        decoration = {
          #rounding = 20;
          rounding = 0;
          inactive_opacity = 1;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
          shadow = {
            color = "rgba(1a1a1aee)";
            range = 4;
            enabled = "yes";
            render_power = 3;
          };
        };

        animations = {
          enabled = "yes";
          bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = { };

        monitor = [
          "DP-2, 2560x1440@144, 0x1080, 1"
          "DP-1, 2560x1440@144, 2560x1080, 1"
          "HDMI-A-2, 1920x1080@60, 2560x0, 1"
        ];

        "$mod" = "SUPER";
        bind = [
          "$mod, W, exec, firefox"
          "$mod, Return, exec, kitty"
          "$mod, Q, killactive"
          "$mod, V, togglefloating"
          "$mod, D, exec, rofi -show drun -config /etc/nixos/assets/rofidmenu.rasi"
          "$mod, P, pseudo"
          "$mod, H, exec, toggle"
          "$mod, J, togglesplit"
          "$mod, S, exec, grimblast --freeze copysave area ~/Pictures/screenshots/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')"
          "$mod, F, fullscreen"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "CTRL, left, swapwindow, l"
          "CTRL, right, swapwindow, r"
          "CTRL, up, swapwindow, hu"
          "CTRL, down, swapwindow, d"
          "$mod, A, layoutmsg, rollnext"
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
        ];

        bindm = [
          "$mod, mouse:273, resizewindow"
          "$mod, mouse:272, movewindow"
        ];

        decoration = { };

        windowrulev2 = [
          "stayfocused, title:^()$,class:^(steam)$"
          "minsize 1 1, title:^()$,class:^(steam)$"
          "stayfocused,class:(Rofi)"
#"forceinput,class:(Rofi)"
          "workspace 7 silent,class:(obs)"
          "workspace 3 silent,class:(vesktop)"
          #"workspace 6 silent,class:(kitty)"
          #"workspace 1 silent,class:(kitty)"
        ];

        workspace = [
          "7,monitor:DP-1,default:false,persistent:true"
          "6,monitor:DP-1,default:false,persistent:true,layoutopt:wslayout-layout:master"
          "1,monitor:DP-2,default:true,persistent:true"
          "2,monitor:DP-1,default:true,persistent:true"
          "3,monitor:HDMI-A-2,default:true,persistent:true"
          "4,monitor:DP-2,default:false,persistent:true"
        ];
      };
    };
}
