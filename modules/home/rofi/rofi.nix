{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    
    # Gunakan config.rasi yang sudah ada
    theme = "~/.config/rofi/launchers/type-7/launcher.sh";
    
    # Config tambahan jika diperlukan
    extraConfig = {
      # Bisa tambah config khusus di sini jika perlu
    };
  };
  
  # Copy semua themes termasuk config.rasi
  home.file.".config/rofi" = {
    source = ./themes;
    recursive = true;
  };
  
  # Scripts untuk berbagai launcher
  home.file.".local/bin/rofi-launcher-t1" = {
    source = ./themes/scripts/launcher_t1;
    executable = true;
  };
  
  home.file.".local/bin/rofi-launcher-t2" = {
    source = ./themes/scripts/launcher_t2;
    executable = true;
  };
  
  home.file.".local/bin/rofi-powermenu" = {
    source = ./themes/scripts/powermenu_t1;
    executable = true;
  };
}