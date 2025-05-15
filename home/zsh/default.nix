{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./ohmyzsh.nix
  ];
}