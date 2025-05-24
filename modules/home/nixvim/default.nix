{ config, pkgs, lib, ... }:

{
  imports = [
    ./default.nix
    ./ui.nix
    ./plugins.nix
  ];
}