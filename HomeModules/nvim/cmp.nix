{ pkgs, ... }:
{
  programs.nixvim = {

  plugins.cmp = {
    enable = true;
    enabled = ''
      function()
        return not require("luasnip").in_snippet()
      end
    '';
    autoEnableSources = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "latex_symbols"; }
        { name = "buffer"; }
      ];
      mapping = {
        "<Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require("luasnip")
            local has_words_before = function()
              unpack = unpack or table.unpack
              local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            if luasnip.in_snippet() and luasnip.jumpable(1) then
              luasnip.jump(1)
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" })
        '';
        "<S-Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require("luasnip")
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        '';
        "<CR>" = "cmp.mapping.confirm({ select = false })";
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
      };
    };
  };
  };
}
