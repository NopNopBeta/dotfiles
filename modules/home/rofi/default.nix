{ config, pkgs, lib, ... }:

{
  imports = [
    ./rofi.nix
    ./theme.nix
  ];
}