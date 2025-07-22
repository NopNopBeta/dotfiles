{ config, pkgs, lib,... }:

{
  imports = [
    ./system/sddm.nix
    ./system/nvidia.nix
  ];
}