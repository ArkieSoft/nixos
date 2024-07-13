{ pkgs, ... }:
{
  programs.waybar =
    {
      enable = true;

      settings = [{
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [ "battery" "tray" "clock" ];
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
          };
          sort-by-number = true;
        };
        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        tray = {
          icon-size = 21;
          spacing = 10;
        };
        clock = {
          format-all = "{:%a, %d. %b %H:%M}";
        };

      }];

      style = ''
        * {
        	border: none;
        	border-radius: 10px;
        	font-family: "JetbrainsMono Nerd Font" ;
        	font-size: 17px;
        	min-height: 10px;
        }

        window#waybar {
        	background: transparent;
        }

        window#waybar.hidden {
        	opacity: 0.2;
        }

        #window {
        	margin-top: 6px;
        	padding-left: 10px;
        	padding-right: 10px;
        	border-radius: 10px;
        	transition: none;
                color: transparent;
        	background: transparent;
        }
        #workspaces {
        	margin-top: 6px;
        	margin-left: 12px;
        	font-size: 4px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	/*background: #ff99e6;*/
        	background: #FF7F50;
          border-color: #9a348e;
        	transition: none;
        }

        #workspaces button {
        	transition: none;
        	color: #B5E8E0;
        	background: transparent;
        	font-size: 16px;
        	border-radius: 2px;
        }

        #workspaces button.occupied {
        	transition: none;
        	color: #F28FAD;
        	background: transparent;
        	font-size: 4px;
        }

        #workspaces button.active {
        	color: #869ef4;
                border-top: 2px solid #869ef4;
                border-bottom: 2px solid #869ef4;
        }

        #workspaces button:hover {
        	transition: none;
        	box-shadow: inherit;
        	text-shadow: inherit;
        	color: #FAE3B0;
            border-color: #E8A2AF;
            color: #E8A2AF;
        }

        #workspaces button.focused:hover {
            color: #E8A2AF;
        }

        #network {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 18px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #bd93f9;
        }

        #pulseaudio {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #1A1826;
        	background: #FAE3B0;
        }

        #battery {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #B5E8E0;
        }

        #battery.charging, #battery.plugged {
        	color: #161320;
            background-color: #B5E8E0;
        }

        #battery.critical:not(.charging) {
            background-color: #B5E8E0;
            color: #161320;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        @keyframes blink {
            to {
                background-color: #BF616A;
                color: #B5E8E0;
            }
        }

        #backlight {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #F8BD96;
        }

        #clock {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #b5e8e0;
        	background: #9a348e;
        }


        /*
        #clock {
        	margin-top: 6px;
        	margin-left: -12px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #b5e8e0;
        	background: #9a348e;
        }


        #tray {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #b5e8e0;
        	background: #9a348e;
        }
        */

        #memory {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	margin-bottom: 0px;
        	padding-right: 10px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #DDB6F2;
        }

        #cpu {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	margin-bottom: 0px;
        	padding-right: 10px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #96CDFB;
        }
        #tray {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	margin-bottom: 0px;
        	padding-right: 10px;
        	border-radius: 10px;
        	transition: none;
        	color: #B5E8E0;
        	/*background: #869ef4;*/
        	background: #00FFFF;
        }
        #custom-launcher {
        	font-size: 24px;
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 5px;
        	border-radius: 10px;
        	transition: none;
            color: #89DCEB;
            background: #161320;
        }

        #custom-power {
        	font-size: 20px;
        	margin-top: 6px;
        	margin-left: 8px;
        	margin-right: 8px;
        	padding-left: 10px;
        	padding-right: 5px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #F28FAD;
        }

        #custom-wallpaper {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #C9CBFF;
        }

        #custom-spotify {
        	margin-top: 6px;
        	margin-left: 8px;
        	padding-left: 10px;
        	padding-right: 10px;
        	margin-bottom: 0px;
        	border-radius: 10px;
        	transition: none;
        	color: #161320;
        	background: #F2CDCD;
        }
      '';

    };
}
