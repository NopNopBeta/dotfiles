{ config, pkgs, ... }:

{
   programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # atau pkgs.rofi untuk X11
    
    # Konfigurasi theme
    theme = "~/.config/rofi/themes/your-theme.rasi";
    
    # Atau bisa langsung styling inline
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{name}";
      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = false;
    };
  }; 
}