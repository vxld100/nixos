{
  programs.nixvim = {
  keymaps = [
    { key = "<leader>h"; action = "<C-w>h"; mode = "n"; }
    { key = "<leader>j"; action = "<C-w>j"; mode = "n"; }
    { key = "<leader>k"; action = "<C-w>k"; mode = "n"; }
    { key = "<leader>l"; action = "<C-w>l"; mode = "n"; }
    { key = "<C-h>"; action = ":vertical resize -2<CR>"; mode = "n"; }
    { key = "<C-l>"; action = ":vertical resize +2<CR>"; mode = "n"; }
    { key = "<C-j>"; action = ":resize +2<CR>"; mode = "n"; }
    { key = "<C-k>"; action = ":resize -2<CR>"; mode = "n"; }
    { key = "J"; action = ":m '>+1<CR>gv=gv"; mode = "v"; }
    { key = "K"; action = ":m '<-2<CR>gv=gv"; mode = "v"; }
    { key = "J"; action = "mzJ'z"; mode = "n"; }
    { key = "<C-d>"; action = "<C-d>zz"; mode = "n"; }
    { key = "<C-u>"; action = "<C-u>zz"; mode = "n"; }
    { key = "n"; action = "nzzzv"; mode = "n"; }
    { key = "N"; action = "Nzzzv"; mode = "n"; }
    { key = "<leader>p"; action = "\"_dP"; mode = "x"; }
    { key = "<leader>d"; action = "\"_d"; mode = "n"; }
    { key = "<leader>d"; action = "\"_d"; mode = "v"; }
    { key = "<leader>y"; action = "\"+y"; mode = "n"; }
    { key = "<leader>y"; action = "\"+y"; mode = "v"; }
    { key = "<leader>e"; action = ":Neotree toggle<CR>"; mode = "n"; }
    { key = "<leader>x"; action = ":!chmod +x %<CR>"; mode = "n"; }
    { key = "<leader>d"; action = ":lua vim.diagnostic.open_float()<CR>"; mode = "n"; }
    { key = "<leader>ca"; action = ":lua vim.lsp.buf.code_action()<CR>"; mode = "n"; }
    { key = "Q"; action = "<nop>"; mode = "n"; }
  ];
  };
}
