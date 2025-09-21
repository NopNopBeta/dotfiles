{
  config,
  pkgs,
  inputs,
  ...
}:
{
  services.desktopManager.gnome.enable = true;

  services.gnome = {
    core-apps.enable = false;
    core-developer-tools.enable = false;
    games.enable = false;
  };
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
  ];
}