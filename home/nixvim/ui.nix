{ config, pkgs, ... }:

{
  programs.nixvim.config = {
    colorschemes.catppuccin.enable = true;  # ✅ Di dalam 'config'
    plugins.lualine.enable = true;
  };
}
