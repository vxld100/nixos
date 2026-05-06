{ config, pkgs, lib, ... }:
{
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 20";
    extraConfig = {
      # We must redefine 'accept' to NOT include Ctrl-j
      kb-accept-entry = "Return,Control+m";
      
      # Assign our Vim keys
      kb-row-down = "Control+j";
      kb-row-up = "Control+k";
      
      # We have to 'unmap' Ctrl-k from its default (delete to end of line)
      kb-remove-to-eol = "";

      # 'normal' means it looks for exact substrings, not fuzzy leaps
      matching = "normal";
      case-sensitive = false;

      # This hides the 'filter' label and makes it look more like a menu
      display-dmenu = "❯";
      drun-display-format = "{name}";

      # For scaling
      dpi = 144;
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg0 = mkLiteral "#0b0c0d";
        bg1 = mkLiteral "#313244";
        fg0 = mkLiteral "#f0f0f0";
        accent = mkLiteral "#cba6f7";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
      };

      "window" = {
        background-color = mkLiteral "@bg0";
        border = mkLiteral "2px";
        border-color = mkLiteral "@accent";
        border-radius = mkLiteral "10px";
        
        # FIX 1: Make the window wider
        width = mkLiteral "1800px"; 
        
        # FIX 2: Add padding so text doesn't touch the borders
        padding = mkLiteral "20px";
      };

      # This wraps everything inside the window
      "mainbox" = {
        spacing = mkLiteral "10px";
        children = mkLiteral "[inputbar, listview]";
      };

      "inputbar" = {
        spacing = mkLiteral "10px";
        padding = mkLiteral "5px";
        # This keeps the prompt and the typing area away from the edges
        children = mkLiteral "[prompt, entry]";
      };

      "listview" = {
        lines = 10;
        columns = 1;
        fixed-height = true;
        # Removed the 10px border here because it usually looks like shit 
        # unless it's the same color as the background. Use spacing instead.
        spacing = mkLiteral "5px";
        border = mkLiteral "0px";
      };

      "element" = {
        padding = mkLiteral "16px";
        spacing = mkLiteral "8px";
        border-radius = mkLiteral "8px";
      };

      "element selected" = {
        background-color = mkLiteral "@bg1";
        text-color = mkLiteral "@accent";
      };
    };
  };
}
