{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    shellIntegration.mode = "no-rc"; #default
    enableGitIntegration = true;

    font = {
      name = "JetBrains Mono Nerd Font";
      size = 30;
    };

    diffConfig.keybindings = {
      gg = "scroll_to start";
      G = "scroll_to end";
      j = "scroll_by 1";
      k = "scroll_by -1";
      u = "scroll_by 10";
      d = "scroll_by -10";
      J = "scroll_to next-file";
      K = "scroll_to prev-file";
      n = "scroll_to next-change";
      p = "scroll_by prev-change";
    };

    settings = {
      background = "#0b0c0d";
      foreground = "#f0f0f0";

      background_opacity = 0.7;
      background_blur = 1;

      window_padding_width = 15;

      confirm_os_window_close = 0;

      cursor_blink_interval = 0;
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.2";

      touch_scroll_multiplier = 4.0;
      scrollbar_width = 0.2;
      scrollbar_handle_opacity = 0.2;

      # Standard Colors
      color0 = "#0e1013"; # black
      color1 = "#e55561"; # red
      color2 = "#8ebd6b"; # green
      color3 = "#d1b86b"; # your custom yellow
      color4 = "#3781bf"; # your custom blue
      color5 = "#bf69d9"; # your custom dark_purple
      color6 = "#48b0bd"; # cyan
      color7 = "#a0a8b7"; # muted grey-white (editor fg)

      # Bright Colors
      color8  = "#535965"; # grey
      color9  = "#e55561"; # bright red
      color10 = "#8ebd6b"; # bright green
      color11 = "#e2b86b"; # default yellow
      color12 = "#4fa6ed"; # default blue
      color13 = "#bf68d9"; # purple
      color14 = "#48b0bd"; # bright cyan
      color15 = "#f0f0f0"; # bright white

      # UI Elements
      selection_background = "#282c34";
      selection_foreground = "#f0f0f0";
      cursor = "#f0f0f0";
      cursor_text_color = "#0a0b0c";
    };
  };
}
