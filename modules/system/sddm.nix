{ config, pkgs, ... }:

let
  sddm-astronaut-patched = pkgs.runCommand "sddm-astronaut-patched" {
    src = pkgs.sddm-astronaut;
  } ''
    # Copy all filesc
    cp -r $src $out
    chmod -R +w $out
    
    # Patch metadata.desktop
    substituteInPlace $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop \
      --replace "ConfigFile=Themes/jake_the_dog.conf" "ConfigFile=Themes/hyprland_kath.conf"
    
    # Debug output
    echo "=== Modified metadata.desktop ==="
    cat $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
  '';
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      sddm-astronaut-patched
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

  environment.systemPackages = [
    sddm-astronaut-patched
  ];
}
