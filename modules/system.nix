{ config, pkgs, lib,... }:

{
  imports = [
    ./system/sddm.nix
    ./system/quickshell/default.nix
  ];
}