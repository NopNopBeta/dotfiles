{ config, pkgs, ... }:

let
  vault-1-15-2 = pkgs.stdenv.mkDerivation rec {
    pname = "vault";
    version = "1.15.2";

    src = pkgs.fetchzip {
      url = "https://releases.hashicorp.com/vault/${version}/vault_${version}_linux_amd64.zip";
      sha256 = "aawDrQu8wEZqJ/uyCJjtWcgy8Ut34B5P+odqddE5P3M="; # Replace with actual hash
      stripRoot = false;
    };

    installPhase = ''
      mkdir -p $out/bin
      cp vault $out/bin/
      chmod +x $out/bin/vault
    '';

    meta = with pkgs.lib; {
      description = "A tool for secrets management, encryption as a service, and privileged access management";
      homepage = "https://www.vaultproject.io/";
      license = licenses.mpl20;
      maintainers = with maintainers; [ ];
      platforms = platforms.linux;
    };
  };
in
{
  environment.systemPackages = [
    vault-1-15-2
  ];
}