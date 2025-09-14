{
  config,
  pkgs,
  inputs,
  ...
}:
{
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
    ansible
    minikube
    net-tools
    vault-1.15.2
  ];
}