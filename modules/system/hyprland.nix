  { config, pkgs, ... }:    
{
  # Tambahkan konfigurasi Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
      grim            # For Screenshot
      slurp           # For Screenshot
      pywal           # For Color management for Hyprland
      hyprpanel       # For Panel
      swappy          # For Screenshot
      hyprlock        # For Lock Session
	    jq              # For Hyprland Screenshot
      lxsession       # if you want access your ntfs or exfat
      brightnessctl   # For Brightness Controll Hyprland
      pamixer         # For Audio Control Hyprland
      networkmanagerapplet #need for connect wifi   
      gnome-keyring #need for connect wifi
      dconf #need for connect wifi
  ];

  environment.sessionVariables = {
    # Nvidia Config
    LIBVA_DRIVER_NAME = "nvidia";  # Use NVIDIA for VA-API
    GBM_BACKEND = "nvidia-drm";    # Required for Wayland
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; #Use nvidia instead of mesa driver
    
    # Wayland & Hyprland Session
    XDG_CURRENT_DESKTOP = "Hyprland"; # Hyprland - GTK
    XDG_SESSION_TYPE = "wayland";     # Wayland Sesssion
    XDG_SESSION_DESKTOP = "Hyprland"; # Hyprland Session
    NIXOS_OZONE_WL = "1";             # Force Software using Wayland Backend 
    GDK_BACKEND = "wayland";          # Using Wayland Backend

    #Browser Setting
    MOZ_ENABLE_WAYLAND = "1";      # Warland Session for firefox
    MOZ_DISABLE_RDD_SANDBOX = "1"; # Required for some browsers
  };
}