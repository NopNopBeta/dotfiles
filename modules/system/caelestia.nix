{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.caelestia = {
      enable = true;
      systemd = {
        enable = true;
      };
      cli.enable = true;

      settings = {
        paths.wallpaperDir = "~/Pictures/Wallpapers";
        # general.apps = {
        #   explorer = "thunar";
        # };
        bar.status.showAudio = true;
      };
    };
}