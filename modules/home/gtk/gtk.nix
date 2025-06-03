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
        name = "adw-gtk3"; # Ganti dengan tema GTK yang Anda gunakan
        package = pkgs.adw-gtk3;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
    };
}