{ config, pkgs, inputs, ... }:
  {
    imports = [
      ./hardware-configuration.nix 
      ./modules/system.nix];

  nix = {
    # Auto-delete unused packages
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

   settings.auto-optimise-store = true;
  };

    # Bootloader
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        configurationLimit = 50;
      };
    };
    boot.kernelParams = [ "loglevel=4" "acpi_osi=Linux" ];
    
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
  
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
        };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Tambahkan konfigurasi Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

    # Environment variables
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      XCURSOR_SIZE = "24";
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
      libva
      libva-utils
      glxinfo
      vulkan-tools
      mesa
      kitty
      vscode
      stow
      tree
      grim
      slurp
      bibata-cursors
      inputs.hyprland.packages.${pkgs.system}.hyprland
      inputs.swww.packages.${pkgs.system}.swww
      rofi
      hyprpanel
      swappy
      hyprlock        # For Lock Session
	    jq
      lxsession       # if you want access your ntfs or exfat
      brightnessctl   # For Brightness Controll Hyprland
      pamixer         # For Audio Control Hyprland
      nautilus        # File Manager
      networkmanagerapplet    
      gnome-keyring
    ];

    # Font config
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    };


    # hardware acceleration
    hardware.graphics = {
      enable = true;
      enable32Bit = true; # for software 32-bit
      extraPackages = with pkgs; [
        intel-media-driver # Intel iGPU
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver # Driver VAAPI NVIDIA
      ];
    };


    # Virt Manager
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["nop"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    #programs.zsh.enable = true; #zsh
 
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

  #waydroid
  #virtualisation.waydroid.enable = true;
}

