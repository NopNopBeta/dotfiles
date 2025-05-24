{ config, pkgs, ... }:

let
  sddm-astronaut-custom = pkgs.sddm-astronaut.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      substituteInPlace $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop \
        --replace "ConfigFile=Themes/astronaut.conf" "ConfigFile=Themes/hyprland_kath.conf"
    '';
  });
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      sddm-astronaut-custom
      qt6.qtmultimedia
      qt6.qtsvg
      qt6.qt5compat
    ];
    settings = {
      General = {
        DisplayServer = "wayland";
      };
      Wayland = {
        SessionDir = "${pkgs.hyprland}/share/wayland-sessions";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    sddm-astronaut-custom
  ];
}