{ pkgs, ... }:
let
  coqScope = pkgs.coqPackages_9_1;
in
{
  home.packages = with pkgs; [
    rocq-core
    coq
    coqScope.stdlib
    coqScope.coq-lsp
  ];

  home.sessionVariables = {
    COQPATH = "${coqScope.stdlib}/lib/coq/9.1/user-contrib";
    ROCQPATH = "${coqScope.stdlib}/lib/coq/9.1/user-contrib";
  };

  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ Coqtail ];

    globals = { coqtail_nomap = 1; };

    keymaps = [
      { mode = "n"; key = "<leader>ci"; action = ":CoqStart<CR>";  options = { silent = true; desc = "Start Coqtail"; }; }
      { mode = "n"; key = "<leader>cj"; action = ":CoqNext<CR>";   options = { silent = true; desc = "Next Goal"; }; }
      { mode = "n"; key = "<leader>ck"; action = ":CoqUndo<CR>";   options = { silent = true; desc = "Undo Goal"; }; }
      { mode = "n"; key = "<leader>cl"; action = ":CoqToLine<CR>"; options = { silent = true; desc = "Check to Cursor"; }; }
      { mode = "n"; key = "<leader>cq"; action = ":CoqStop<CR>";   options = { silent = true; desc = "Stop Coqtail"; }; }
    ];

    plugins.lsp.servers.coq_lsp = {
      enable = true;
      cmd = [
        "${coqScope.coq-lsp}/bin/coq-lsp"
        "--ocamlpath=${coqScope.coq-lsp}/lib/ocaml/${coqScope.coq.ocamlPackages.ocaml.version}/site-lib"
      ];
    };

    autoCmd = [{ event = "BufRead"; pattern = "*.v"; command = "set ft=coq"; }];
  };
}
