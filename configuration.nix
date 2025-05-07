{ config, pkgs, lib, ... }:
  {
    imports = [ ./hardware-configuration.nix ];

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
 
  #Gnome
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
       pkgs.xdg-desktop-portal-gtk
     ];
     configPackages = [
       pkgs.xdg-desktop-portal-gtk
     ];
   };

  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };


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
    };


    # System packages
    environment.systemPackages = with pkgs; [
      kitty
      vscode
      stow
      tree
      grim
      slurp
      bibata-cursors
      gnome-menus
      gnomeExtensions.pop-shell
      # sddm-astronaut
    ];

    # Font config
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    # System config
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.05";  # Changed to match flake
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Nvidia
    hardware.graphics = {
      enable = true;
    };

    hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    services.xserver.videoDrivers = ["nvidia"];

    # Virt Manager
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["nop"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    #zsh config
   programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ 
        "git" 
        "sudo" 
        "docker" 
        "npm" 
        "rust" 
        "python" 
        "history" 
      ];

      theme = "robbyrussell";  # Ganti dengan tema yang diinginkan (e.g., "agnoster")
      customPkgs = with pkgs; [
        zsh-autosuggestions
        zsh-syntax-highlighting
        zsh-completions
        zsh-powerlevel10k
      ];
    };
  };

#Steam
    programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Auto detect mounting
    #services.devmon.enable = true;
    #services.gvfs.enable = true; 
    #services.udisks2.enable = true;
    #security.polkit.enable = true;
    #boot.supportedFilesystems = [ "ntfs" "exfat"];

  #fix bug bluetooth
    #services.upower.enable = true;
    #services.libinput.enable = true;
    #hardware.bluetooth.enable = true;
    #hardware.bluetooth.powerOnBoot = false;
    #services.blueman.enable = true;

  #waydroid
  #virtualisation.waydroid.enable = true;
}

