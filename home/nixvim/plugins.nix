{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    telescope.enable = true;
    neo-tree.enable = true;
    lsp.enable = true;
    dashboard.enable = true;
    lazy.enable = true;
    friendly-snippets.enable = true;
    web-devicons.enable = true;
    mini.enable = true;
  };

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    vim-nix
    nvim-treesitter
    lazy-nvim
    neo-tree-nvim
    nvim-cmp
    cmp-nvim-lsp
    nvim-lspconfig
    telescope-nvim
    dashboard-nvim
  ];
}
