{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # ./vault.nix
    ./minikube.nix
  ];

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
    ansible
    net-tools
  ];

}
