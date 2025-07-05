{ config, pkgs, lib,... }:

{
  imports = [
    ./home/nixvim/default.nix
    ./home/zsh/default.nix
    ./home/rofi/default.nix
    ./home/zoom/default.nix
    ./home/gtk/gtk.nix
    ./home/spicetify/spicetify.nix
    ./home/quickshell/quickshell.nix
  ];
}