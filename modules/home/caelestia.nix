{
  config,
  pkgs,
  inputs,
  ...
}:
{

imports = [
  inputs.caelestia-shell.homeManagerModules.default
];

programs.caelestia = {
  enable = true;
  systemd = {
    enable = true; # if you prefer starting from your compositor
    target = "graphical-session.target";
    environment = [];
  };
  settings = {
    bar.status = {
      showBattery = true;
    };
    paths.wallpaperDir = "/home/nop/Pictures/Wallpapers";
  };
  cli = {
    enable = true; # Also add caelestia-cli to path
    settings = {
      theme.enableGtk = false;
    };
  };
};
}
