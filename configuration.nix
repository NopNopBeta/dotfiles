{ config, pkgs, lib, ... }:
  {
    imports = [ ./hardware-configuration.nix ];

    # Bootloader
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Network
    networking = {
      hostName = "nixos";
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

  # Use Qt6 SDDM from KDE packages
  services.xserver.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;  # Explicit Qt6 version
      theme = "sddm-astronaut-theme";  # Verify theme directory name in package
      
      extraPackages = with pkgs; [
        sddm-astronaut  # The theme package (check exact name)
        qt6.qtmultimedia
        qt6.qtsvg
        qt6.qt5compat  # Often needed for compatibility
      ]; 
    };

    # Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
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
      extraGroups = [ "networkmanager" "wheel" "video" "storage" ];
      shell = pkgs.zsh;
    };


    # System packages
    environment.systemPackages = with pkgs; [
      kitty
      vscode
      hyprpanel
      rofi
      stow
      tree
      swappy
      grim
      slurp
      oh-my-zsh
      zsh
      bibata-cursors
      lxde.lxsession
      sddm-astronaut
      kvantum
    ];

    # Font config
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    # System config
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.11";  # Changed to match flake
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
  
}

