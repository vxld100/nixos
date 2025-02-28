{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;

    settings = {
      font-size = 15;
      font-family = "JetBrains Mono Nerd Font";

      background = "#0b0c0d";
      foreground = "#f0f0f0";

      confirm-close-surface = false;
      resize-overlay = "never";

      background-opacity = 0.7;
      background-blur = true;

      window-padding-x = 15;
      window-padding-y = 15;

      shell-integration-features = "no-cursor";
      cursor-style = "underline";
      cursor-style-blink = false;
    };
  };
}
