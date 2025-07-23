{ config, pkgs, inputs, lib,... }:
{
  # nixpkgs.config.allowUnfree = true;
  
  imports = [
    ./modules/home.nix
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
    inputs.zen-browser.packages."${pkgs.system}".default
    cava
    transmission_4-qt
    telegram-desktop
    unzip
    lutris
    unrar
    yt-dlp
    libreoffice-qt
    cmatrix
    tree
    mpv
    amberol
    nautilus
    inputs.caelestia.packages."${pkgs.system}".default

  ];

  # programs.bash = {
  #   enable = true;
  #   shellAliases.ll = "ls -l";
  # };

#  #Cursor setting
#     home.pointerCursor = {
#       name = "Bibata-Modern-Ice";
#       package = pkgs.bibata-cursors;
#       size = 24;
#       # x11.enable = true;
#     };

  programs.firefox.enable = true;  # Moved from system config
}
