{ pkgs, ... }:

{
  # Ensure the Coq binary and LSP server are available in the environment
  home.packages = with pkgs; [
    rocq-core
  ];

  programs.nixvim = {
    # 1. Install Coqtail via extraPlugins since there is no native NixVim module yet
    extraPlugins = with pkgs.vimPlugins; [
      coqtail
    ];

    # 2. Configure Coqtail Globals
    globals = {
      # Prevents Coqtail from using its default (often clashing) keybindings
      coqtail_nomap = 1;
    };

    # 3. Interactive Proof Keybindings
    # These mimic the standard Coqtail flow using your <leader>
    #keymaps = [
    #  {
    #    mode = "n";
    #    key = "<leader>ci"; # Coq Init
    #    action = ":CoqStart<CR>";
    #    options = { silent = true; desc = "Start Coqtail"; };
    #  }
    #  {
    #    mode = "n";
    #    key = "<leader>cj"; # Coq Down (Jump)
    #    action = ":CoqNext<CR>";
    #    options = { silent = true; desc = "Next Goal"; };
    #  }
    #  {
    #    mode = "n";
    #    key = "<leader>ck"; # Coq Up (Kill)
    #    action = ":CoqUndo<CR>";
    #    options = { silent = true; desc = "Undo Goal"; };
    #  }
    #  {
    #    mode = "n";
    #    key = "<leader>cl"; # Coq Line
    #    action = ":CoqToLine<CR>";
    #    options = { silent = true; desc = "Check to Cursor"; };
    #  }
    #  {
    #    mode = "n";
    #    key = "<leader>cq"; # Coq Quit
    #    action = ":CoqStop<CR>";
    #    options = { silent = true; desc = "Stop Coqtail"; };
    #  }
    #];

    # 4. LSP Configuration for Diagnostics & Completion
    plugins.lsp.servers.coq_lsp = {
      enable = true;
      # We let NixVim find the package from home.packages or default nixpkgs
    };

    # 5. Filetype detection fix
    autoCmd = [
      {
        event = "BufRead";
        pattern = "*.v";
        command = "set ft=coq";
      }
    ];
  };
}
