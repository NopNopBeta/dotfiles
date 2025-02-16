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
  ];

  programs.bash = {
    enable = true;
    shellAliases.ll = "ls -l";
  };

  programs.firefox.enable = true;  # Moved from system config
}