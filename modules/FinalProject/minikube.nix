{ config, pkgs, ... }:

let
  minikube-old = pkgs.stdenv.mkDerivation rec {
    pname = "minikube";
    version = "1.28.0";
    
    src = pkgs.fetchurl {
      url = "https://github.com/kubernetes/minikube/releases/download/v${version}/minikube-linux-amd64";
      sha256 = "WM6tXs6YFaYdS+JToHsjhfjPNz2eHrpcl4NETk6eLY4="; # Replace with actual hash
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