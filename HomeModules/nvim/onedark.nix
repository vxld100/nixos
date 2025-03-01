{
  programs.nixvim = {
  colorschemes.onedark = {
    enable = true;
    settings = {
      style = "darker";
      transparent = true;  # Enable transparent background
      colors = {
        bg0 = "#0a0b0c";
        fg = "#f0f0f0";
        yellow = "#d1b86b";
        dark_purple = "#5b4c8f";
        blue = "#3781bf";
      };
      highlights = {
        "@namespace" = { fg = "$orange"; };
        "@number" = { fg = "$yellow"; };
        "@type" = { fg = "$red"; };
        "@keyword.type" = { fg = "$blue"; };
        "@function" = { fg = "$orange"; };
        "@selector" = { fg = "$dark_cyan"; };
        "@repeat" = { fg = "$dark_purple"; };
        "@keyword.repeat" = { fg = "$dark_purple"; };
      };
    };
  };
  };
}
