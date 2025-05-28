{ config, pkgs, inputs, lib,... }:
{
  # nixpkgs.config.allowUnfree = true;
  
  imports = [
    ./modules/home.nix
    inputs.nixvim.homeManagerModules.nixvim # Import the nixvim module
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.stateVersion = "25.05";
  home.username = "nop";
  home.homeDirectory = "/home/nop";

  home.packages = with pkgs; [
    htop
    discord
    bitwarden
    git
    qemu
    fastfetch
    zoom-us
    inputs.zen-browser.packages."${pkgs.system}".default
    cava
    transmission_4-qt
    telegram-desktop
    unzip
    lutris
    unrar
    yt-dlp
    amberol
    vlc
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH
    brave
    cmatrix
  ];

  programs.bash = {
    enable = true;
    shellAliases.ll = "ls -l";
  };

 #Cursor setting
    home.pointerCursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
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

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.comfy;
  };

}
