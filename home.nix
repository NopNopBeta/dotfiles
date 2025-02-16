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
    nautilus
    fastfetch
    mpv
    inputs.swww.packages.${pkgs.system}.swww
    bibata-cursors 

  ];

  programs.bash = {
    enable = true;
    shellAliases.ll = "ls -l";
  };

  home.pointerCursor = {
  name = "Bibata-Modern-Ice";
  package = pkgs.bibata-cursors;
  size = 24;  # Adjust size as needed
  gtk.enable = true;
  x11.enable = true;
};

  programs.firefox.enable = true;  # Moved from system config
}