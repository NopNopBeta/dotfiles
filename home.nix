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


    fish
    foot
    chafa
    inputs.caelestia.packages."${pkgs.system}".default
    inputs.caelestia-cli.packages."${pkgs.system}".default
  ];

  programs.firefox.enable = true;  # Moved from system config
}
