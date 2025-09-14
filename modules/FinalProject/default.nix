{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./vault.nix
  ];
}
