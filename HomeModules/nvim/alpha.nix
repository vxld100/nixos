{
  programs.nixvim = {
  plugins.alpha = {
    enable = true;
    settings.layout = [
      { type = "padding"; val = 2; }
      {
        type = "text";
        val = [
          "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
          "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
        ];
        opts = {
          position = "center";
          hl = "AlphaHeader";
        };
      }
      { type = "padding"; val = 2; }
      {
        type = "group";
        val = [
          {
            type = "button";
            val = "  New file";
            on_press = "<cmd>lua new_file()<CR>";
            opts = {
              position = "center";
              shortcut = "SPC e";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
	  { type = "padding"; val = 1; }
          {
            type = "button";
            val = "󰈞  Find file";
            on_press = "Telescope find_files";
            opts = {
              position = "center";
              shortcut = "SPC f f";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
	  { type = "padding"; val = 1; }
          {
            type = "button";
            val = "󰊄  Recently opened files";
            on_press = "Telescope oldfiles";
            opts = {
              position = "center";
              shortcut = "SPC f h";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
	  { type = "padding"; val = 1; }
          {
            type = "button";
            val = "  Frecency/MRU";
            on_press = "Telescope frecency";
            opts = {
              position = "center";
              shortcut = "SPC f r";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
	  { type = "padding"; val = 1; }
          {
            type = "button";
            val = "󰈬  Find word";
            on_press = "Telescope live_grep";
            opts = {
              position = "center";
              shortcut = "SPC f g";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
	  { type = "padding"; val = 1; }
          {
            type = "button";
            val = "  Jump to bookmarks";
            on_press = "Telescope marks";
            opts = {
              position = "center";
              shortcut = "SPC f m";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
	  { type = "padding"; val = 1; }
          {
            type = "button";
            val = "  Open last session";
            on_press = "SessionLoad";
            opts = {
              position = "center";
              shortcut = "SPC s l";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
        ];
      }
      { type = "padding"; val = 2; }
    ];
  };

  highlight = {
    AlphaHeader = {
      fg = "#4fadf7";
    };
  };

  extraConfigLua = ''
    vim.api.nvim_set_keymap('n', '<leader>fe', ':lua new_file()<CR>', {noremap = true, silent = true})

    function new_file()
      vim.cmd('enew')
      vim.cmd('startinsert')
    end
  '';
  };
}
