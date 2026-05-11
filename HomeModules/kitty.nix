{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    shellIntegration.mode = "no-rc"; #default
    enableGitIntegration = true;

    font = {
      name = "JetBrains Mono Nerd Font";
      size = 15;
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
      background_blur = 0.5;
    };
  };
}
