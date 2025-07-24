{ config, lib, pkgs, ... }:
{ 
  programs.dconf.enable = true; # Diperlukan untuk beberapa tema GTK

  environment.systemPackages = with pkgs; [
    adw-gtk3
    papirus-icon-theme
    bibata-cursors
    qt6ct
  ];
  
  # Font config
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  
  environment.sessionVariables = {
    #Theme
      GTK_THEME = "adw-gtk3-dark";
      QT_STYLE_OVERRIDE = "adwaita-dark";  # Untuk konsistensi QT
      QT_QPA_PLATFORMTHEME = "qt6ct";

    # Cursor Config
      XCURSOR_THEME = "Bibata-Modern-Ice"; # Cursor Theme 
      XCURSOR_SIZE = "24"; # Cursor Size
      WLR_NO_HARDWARE_CURSORS = "1"; # Use CPU for cursor movement
    };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}