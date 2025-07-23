{ config, lib, pkgs, ... }:
{ 
    # Tambahkan konfigurasi GTK
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark"; # Ganti dengan tema ikon yang Anda gunakan
        package = pkgs.papirus-icon-theme;
      };
      theme = {
        name = "adw-gtk3-dark"; # Ganti dengan tema GTK yang Anda gunakan
        package = pkgs.adw-gtk3;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
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