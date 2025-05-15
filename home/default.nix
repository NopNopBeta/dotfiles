{ config, pkgs, lib,... }:

{
  imports = [
    ./nixvim/default.nix
    ./zsh/default.nix
  ];
}