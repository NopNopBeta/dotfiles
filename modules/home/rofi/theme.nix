{ config, pkgs, ... }:

{
    home.file.".config/rofi/themes" = {
    source = "${pkgs.fetchFromGitHub {
      owner = "adi1090x";
      repo = "rofi";
      rev = "master"; # atau commit hash spesifik
      sha256 = "sha256-HASH"; # dapatkan dengan nix-prefetch-url
    }}/files";
    recursive = true;
  };
}