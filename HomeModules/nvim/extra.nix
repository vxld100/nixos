{pkgs, ...}: {
  programs.nixvim.extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
    name = "luasnip-latex-snippets.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "evesdropper";
      repo = "luasnip-latex-snippets.nvim";
      rev = "c6b5b5367dd4bb8419389f5acf528acf296adcdd";
      hash = "sha256-calv4nF1yxJyehQC+l0p4psI+f4Kg49K6XziCkH9I1Q=";
    };
  })];
}
