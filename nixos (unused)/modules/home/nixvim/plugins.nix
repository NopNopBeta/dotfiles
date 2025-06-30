{ config, pkgs, ... }:

{
  # Put everything inside the config attribute block
  programs.nixvim.config = {
    # Plugins configuration
    plugins = {
      telescope.enable = true;
      neo-tree.enable = true;
      lsp.enable = true;
      dashboard.enable = true;
      lazy.enable = true;
      friendly-snippets.enable = true;
      web-devicons.enable = true;
      mini.enable = true;
    };
    
    # Extra plugins that don't have nixvim modules
    extraPlugins = with pkgs.vimPlugins; [
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
  };
}