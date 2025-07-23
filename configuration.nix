{ config, pkgs, inputs, ... }:
  {
    imports = [
      ./hardware-configuration.nix 
      ./modules/system.nix 
    ];

  nix = {
    # Auto-delete unused packages
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

   settings.auto-optimise-store = true;
  };

    # Network
    networking = {
      hostName = "Dreamer";
      networkmanager.enable = true;
    };

    # System config
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.05";  # Changed to match flake
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      experimental-features = [ "nix-command" "flakes" ];
    };
    
    # Localization
    time.timeZone = "Asia/Jakarta";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };

    # Audio
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # User
    users.users.nop = {
      isNormalUser = true;
      description = "nop";
      extraGroups = [ "networkmanager" "wheel" "video" "storage" "docker" ];
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
    };

    # System packages
    environment.systemPackages = with pkgs; [
      kitty           # Terminal
      vscode          # Code
      grim            # For Screenshot
      slurp           # For Screenshot
      # bibata-cursors  # package for Cursor
      # inputs.hyprland.packages.${pkgs.system}.hyprland # Hyprland
      # inputs.swww.packages.${pkgs.system}.swww         # For Wallpaper (Not Needed now because using Hyprpanel) 
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
      nur.repos.ataraxiasjel.waydroid-script 
    ];

    # Font config
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

  # Virt Manager
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["nop"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
 
  #Steam
    programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Auto detect mounting
    services.devmon.enable = true;
    services.gvfs.enable = true; 
    services.udisks2.enable = true;
    security.polkit.enable = true;
    boot.supportedFilesystems = [ "ntfs" "exfat"];

  #fix bug bluetooth
    services.upower.enable = true;
    services.libinput.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = false;
    services.blueman.enable = true;


  # Warp-CLI
    services.cloudflare-warp.enable = true;

  # waydroid
  virtualisation.waydroid.enable = true;
}

