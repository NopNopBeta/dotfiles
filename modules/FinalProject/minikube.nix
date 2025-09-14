{ config, pkgs, ... }:

let
  minikube-old = pkgs.stdenv.mkDerivation rec {
    pname = "minikube";
    version = "1.28.0";
    
    src = pkgs.fetchurl {
      url = "https://github.com/kubernetes/minikube/releases/download/v${version}/minikube-linux-amd64";
      sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with actual hash
    };
    
    dontUnpack = true;
    
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/minikube
      chmod +x $out/bin/minikube
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    minikube-old
  ];
}