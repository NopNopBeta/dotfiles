{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./home/nixvim/default.nix
    # ./home/rofi/default.nix
    ./home/zoom/default.nix
    ./home/spicetify/spicetify.nix
  ];
}
