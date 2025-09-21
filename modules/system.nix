{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./system/sddm.nix
    ./system/nvidia.nix
    ./system/grub2.nix
    ./system/gtk.nix
    ./system/hyprland.nix
    ./system/shell.nix
    ./system/packettracer.nix
    ./system/gnome.nix


    ./FinalProject/default.nix
  ];
}
