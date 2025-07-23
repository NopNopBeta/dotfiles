{ config, pkgs, ... }:
{
  # Bootloader
  boot.kernelPackages = pkgs.linuxPackages_zen;
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

    boot.loader.grub2-theme = {
      enable = true;
      theme = "vimix";
      footer = true;
      customResolution = "1600x900";  # Optional: Set a custom resolution
    };

    boot.kernelParams = [ "quite" "splash" "loglevel=3" "acpi_osi=Linux" "nvidia_drm.modeset=1"];
    
}