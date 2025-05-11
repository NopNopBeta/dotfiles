{ config, pkgs, ... }:

{
  programs.nixvim.colorschemes.catppuccin.enable = true;
  programs.nixvim.plugins.lualine.enable = true;
}
