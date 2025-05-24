{ config, pkgs, lib,... }:

{
  imports = [
    ./home/nixvim/default.nix
    ./home/zsh/default.nix
  ];
}