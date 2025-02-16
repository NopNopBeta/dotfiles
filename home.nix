{ config, pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;


  home.stateVersion = "23.11";
  home.username = "nop";
  home.homeDirectory = "/home/nop";

  home.packages = with pkgs; [
    htop
    neovim
    discord
    bitwarden
    git
    qemu
    dolphin
    fastfetch
    mpv
    inputs.swww.packages.${pkgs.system}.swww
  ];

  programs.bash = {
    enable = true;
    shellAliases.ll = "ls -l";
  };

 # Cursor setting
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Tambahkan konfigurasi GTK
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark"; # Ganti dengan tema ikon yang Anda gunakan
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita-dark"; # Ganti dengan tema GTK yang Anda gunakan
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  programs.firefox.enable = true;  # Moved from system config
}