{ config, pkgs, inputs, ... }:
{
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      fullAppDisplay
      popupLyrics
      powerBar
  ];
    theme = spicePkgs.themes.burntSienna;
    # colorScheme = "blue-light";
  };
}