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
    stow
    tree
    mpv
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

  programs.firefox.enable = true;  # Moved from system config
}
