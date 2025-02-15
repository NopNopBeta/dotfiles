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

  # X11/Wayland
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    xkb.layout = "us";
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
    extraGroups = [ "networkmanager" "wheel" "video" ];
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
    exfat
    ntfs3g
    oh-my-zsh
    zsh
    zsh-completions
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-history-substring-search
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
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  #Steam
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

}

