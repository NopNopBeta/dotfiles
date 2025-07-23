{ config, pkgs, ... }:    
  {
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      nvidiaSettings = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      
      prime = {
        offload.enable = false;      # Disable because using Nvidia Sync
        reverseSync.enable = false;  # Disable because using Nvidia Sync
        sync.enable = true;          # Enable Nvidia Sync
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    # hardware acceleration
    hardware.graphics = {
      enable = true;
      enable32Bit = true; # for software 32-bit
      extraPackages = with pkgs; [
        intel-media-driver # Intel iGPU
        vaapiVdpau
        libvdpau-va-gl
        vulkan-validation-layers
        vulkan-loader
        nvidia-vaapi-driver # Driver VAAPI NVIDIA
      ];
    };

    services.xserver = {
      enable = true;
      # Load nvidia driver for Xorg and Wayland
      videoDrivers = ["nvidia"];
    };
  }