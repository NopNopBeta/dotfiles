{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  # nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/home.nix
  ];

  home.stateVersion = "25.11";
  home.username = "nop";
  home.homeDirectory = "/home/nop";

  home.packages = with pkgs; [
    htop
    discord
    bitwarden-desktop
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
    cmatrix
    tree
    mpv
    amberol
    nautilus
    vscode # Code
    transmission_4-qt
    osu-lazer-bin
    kittysay
    wpsoffice
    glxinfo
    kubectl
    kubernetes-helm
    nixfmt
    mpvpaper
    wrk
    nodejs
    obsidian
    lens
  ];
  
  programs.firefox.enable = true; # Moved from system config
}
