{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # atau pkgs.rofi untuk X11
    
    # Gunakan config.rasi yang sudah ada
    theme = "~/.config/rofi/config.rasi";
  };
  
  # Copy semua themes ke ~/.config/rofi
  home.file.".config/rofi" = {
    source = ./themes;
    recursive = true;
  };
  
  # Scripts untuk launcher dan powermenu
  home.file.".local/bin/rofi-launcher" = {
    source = ./themes/scripts/launcher_t1;
    executable = true;
  };
  
  home.file.".local/bin/rofi-powermenu" = {
    source = ./themes/scripts/powermenu_t1;
    executable = true;
  };
}