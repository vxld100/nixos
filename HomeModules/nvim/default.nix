{ pkgs, ... }:


{
  # Import all your configuration modules here
  imports = [ 
    ./bufferline.nix 
    ./cmp.nix
    ./keymaps.nix
    ./onedark.nix
    ./alpha.nix
    ./neo-tree.nix
    ./ada-ls.nix
    #./extra.nix
  ];
  programs.nixvim = {

  plugins = {
    lualine.enable = true;
    cmp_luasnip.enable = true;
    #friendly-snippets.enable = true;
    nvim-autopairs.enable = true;
    flash.enable = true;
    cmp-latex-symbols.enable = true;
    #barbecue.enable = true;
    markdown-preview.enable = true;

    luasnip = {
      enable = true;
      fromSnipmate = [
      {
	paths = ./snippets;
	exclude = [ "all" ];
	lazyLoad = true;
      }
      ];
    };

    treesitter = {
      enable = true;
    };

    toggleterm = {
      enable = true;
      settings = {
	open_mapping = "[[<c-o>]]";
	direction = "float";
	floatOpts = {
	  border = "curved";
	  height = 30;
	  width = 130;
	};
      };
    };

	 web-devicons.enable = true;

    telescope = {
      enable = true;
      keymaps = {
	"<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
	"<leader>fb" = "buffers";
	"<leader>fh" = "help_tags";
      };
    };


    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        pyright.enable = true;
	ltex.enable = true;
      };
      preConfig = ''
        vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "⚑", texthl = "DiagnosticSignHint" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = "»", texthl = "DiagnosticSignInfo" })
      '';
    };
  };

  globals.mapleader = " ";

  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    signcolumn = "yes";
    wrap = false;
    hlsearch = false;
    incsearch = true;
  };

  autoCmd = [
    {
      event = "VimLeave";
      pattern = "*";
      command = "lua vim.o.guicursor='a:hor20'";
    }
  ];
  };
}
