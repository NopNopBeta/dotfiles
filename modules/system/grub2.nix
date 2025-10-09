{ config, pkgs, ... }:
{
  # Bootloader
  boot.kernelPackages = pkgs.linuxPackages;

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
    customResolution = "1600x900";
  };

  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "acpi_osi=Linux"
    "nvidia_drm.modeset=1"
    "acpi_mask_gpe=0x0"
  ];
  boot.consoleLogLevel = 3;
}
