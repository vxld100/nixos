{pkgs, ...}: {
  extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
    name = " luasnip-latex-snippets.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "evesdropper";
      repo = "luasnip-latex-snippets.nvim";
      rev = "c6b5b5367dd4bb8419389f5acf528acf296adcdd";
      hash = "<nix NAR hash>";
    };
  })];
}
