{ pkgs, config, ... }:
let
  selected-normal-foreground = "rgba ( 255, 147, 5, 100 % )";
  foreground = "rgba ( 196, 203, 212, 100 % )";
  normal-foreground = foreground;
  alternate-normal-background = "rgba ( 45, 48, 59, 1 % )";
  red = "rbga ( 220, 50, 47, 100 % )";
  selected-urgent-foreground = "rgba ( 249, 249, 249, 100 % )";
  blue = "rbga ( 38, 139, 210, 100 % )";
  urgent-foreground = "rgba ( 204, 102, 102, 100 % )";
  alternate-urgent-background = "rgba ( 75, 81, 96, 90 % )";
  active-foreground = "rgba ( 101, 172, 255, 100 % )";
  lightbg = "rgba ( 238, 2332, 213, 100 % )";
  selected-active-foreground = selected-urgent-foreground;
  alternate-active-background = "rgba ( 45, 48, 59, 88 % )";
  background = "rgba ( 45, 48, 59, 88% )";
  normal-background = background;
  lightfg = "rgba ( 88, 104, 117, 100 % )";
  selected-normal-background = "rgba ( 24, 26, 32, 100 % )";
  border-color = "rgba ( 124, 131, 137, 100 % )";
  seperatorcolor = "rgba ( 45, 48, 59, 88 % )";
  urgent-background = "rgba ( 45, 48, 59, 1 % )";
  selected-urgent-background = "rgba ( 165, 66, 66, 100 % )";
  alternate-urgent-foreground = urgent-foreground;
  background-color = "rgba ( 0, 0, 0, 0 % )";
  alternate-active-foreground = active-foreground;
  active-background = "rgba ( 29, 31, 33, 17 % )";
  selected-active-background = "rgba ( 26, 28, 35, 100 %)";
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    location = "center";
    package = pkgs.rofi-wayland;
    theme = {
      "configuration" = {
        font = "Noto Sans Regular 10";
        show-icons = true;
        icon-theme = "Qogir";
        display-drun = "Apps";
        drun-display-format = "{name}";
        scroll-method = 0;
        disable-history = false;
        sidebar-mode = false;
      };
      "window" = {
        background-color = mkLiteral background;
        border = 0;
        padding = 30;
      };
      "listview" = {
        lines = 10;
        columns = 3;
        fixed-height = 0;
        border = mkLiteral "8px 0px 0px";
        border-color = mkLiteral seperatorcolor;
        spacing = mkLiteral "8px";
        scrollbar = false;
        padding = mkLiteral "2px 0px 0px";
        background-color = background;
      };
      "mainbox" = {
        border = 0;
        padding = 0;
        background-color = background;
      };
      "message" = {
        border = mkLiteral "2px 0px 0px";
        border-color = mkLiteral seperatorcolor;
        padding = mkLiteral "1px";
        background-color = background;
      };
      "textbox" = {
        text-color = mkLiteral foreground;
        background-color = background;
      };
      "element" = {
        border = 0;
        background-color = background;
        padding = mkLiteral "1px";
      };
      "element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element.normal.normal" = {
        background-color = mkLiteral normal-background;
        text-color = mkLiteral normal-foreground;
      };
      "element.normal.urgent" = {
        background-color = mkLiteral normal-background;
        text-color = mkLiteral normal-foreground;
      };
      "element.normal.active" = {
        background-color = mkLiteral active-background;
        text-color = mkLiteral active-foreground;
      };
      "element.selected.normal" = {
        background-color = mkLiteral selected-normal-background;
        text-color = mkLiteral selected-normal-foreground;
      };
      "element.selected.urgent" = {
        background-color = mkLiteral selected-urgent-background;
        text-color = mkLiteral selected-urgent-foreground;
      };
      "element.selected.active" = {
        background-color = mkLiteral selected-active-background;
        text-color = mkLiteral selected-active-foreground;
      };
      "element.alternate.normal" = {
        background-color = mkLiteral normal-background;
        text-color = mkLiteral foreground;
      };
      "element.alternate.active" = {
        background-color = mkLiteral active-background;
        text-color = mkLiteral alternate-active-foreground;
      };
      "element.alternate.urgent" = {
        background-color = mkLiteral urgent-background;
        text-color = mkLiteral alternate-urgent-foreground;
      };
      "scrollbar" = {
        width = mkLiteral "4px";
        border = 0;
        handle-color = mkLiteral normal-foreground;
        hendle-width = mkLiteral "8px";
        padding = 0;
      };
      "mode-switcher" = {
        border = mkLiteral "2px 0px 0px";
        border-color = mkLiteral seperatorcolor;
      };
      "button" = {
        background-color = background;
        spacing = 0;
        text-color = mkLiteral normal-foreground;
      };
      "button.selected" = {
        background-color = mkLiteral selected-normal-background;
        text-color = mkLiteral selected-normal-foreground;
      };
      "inputbar" = {
        spacing = 0;
        text-color = mkLiteral normal-foreground;
        padding = mkLiteral "1px";
        children = mkLiteral "[ prompt,textbox-prompt-colon,entry,case-indicator ]";
      };
      "case-indicator" = {
        spacing = 0;
        text-color = mkLiteral normal-foreground;
      };
      "entry" = {
        spacing = 0;
        text-color = mkLiteral normal-foreground;
      };
      "prompt" = {
        spacing = 0;
        text-color = mkLiteral normal-foreground;
      };
      textbox-prompt-colon = {
        expand = false;
        str = ":";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = mkLiteral normal-foreground;
      };
    };
  };
}
