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
      networkmanager = {
        enable = true;
        # WiFi MAC randomization
        wifi = {
          macAddress = "random";
          scanRandMacAddress = true;
        };
        # Ethernet MAC randomization (if supported in your NixOS version)
        ethernet.macAddress = "random";
      };

      firewall = {
        checkReversePath = false;
        trustedInterfaces = [ "virbr0" "incusbr0"];
      };
    };
    # System config
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.11";
    nix.settings = {
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
      extraGroups = [ "networkmanager" "wheel" "video" "storage" "incus-admin" "docker" ];
      shell = pkgs.zsh;
    };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;  # Start Docker on boot
  };
  
  environment.systemPackages = with pkgs; [
    docker-compose  # Optional: For Docker Compose
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

    # fix bug bluetooth
    services.upower.enable = true;
    services.libinput.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = false;
    services.blueman.enable = true;
    
    # Warp-CLI
    services.cloudflare-warp.enable = true;

    # Incus (Virtualization manager)
    virtualisation.incus = {
      enable = true;
      ui.enable = true;
    };

    # Incus Depedency (For open Firewall
    networking.nftables.enable = true;
}

