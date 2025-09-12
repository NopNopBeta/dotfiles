{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./nixvim.nix
    ./ui.nix
    ./plugins.nix
  ];
}
