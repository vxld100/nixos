{
  programs.rofi = {
    enable = true;
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
    };
  };
}
