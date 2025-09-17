{ config, pkgs, ... }:
let
  vault-1-15-2 = pkgs.stdenv.mkDerivation rec {
    pname = "vault";
    version = "1.15.2";
    src = pkgs.fetchzip {
      url = "https://releases.hashicorp.com/vault/${version}/vault_${version}_linux_amd64.zip";
      sha256 = "aawDrQu8wEZqJ/uyCJjtWcgy8Ut34B5P+odqddE5P3M=";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out/bin
      cp vault $out/bin/
      chmod +x $out/bin/vault
    '';
  };

  # Create vault configuration file using /var/lib/vault
  vaultConfig = pkgs.writeText "vault.hcl" ''
    ui = true
    storage "file" {
      path = "/var/lib/vault/data"
    }
    listener "tcp" {
      address = "0.0.0.0:8200"
      tls_disable = 1
    }
    api_addr = "http://127.0.0.1:8200"
    cluster_addr = "https://127.0.0.1:8201"
  '';
in
{
  environment.systemPackages = [ vault-1-15-2 ];

  users.groups.vault = {};
  users.users.vault = {
    isSystemUser = true;
    group = "vault";
    home = "/var/lib/vault";
    createHome = true;
  };

  systemd.services.vault = {
    description = "HashiCorp Vault";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    
    serviceConfig = {
      Type = "notify";
      User = "vault";
      Group = "vault";
      ExecStart = "${vault-1-15-2}/bin/vault server -config=${vaultConfig}";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      LimitNOFILE = 65536;
      LimitMEMLOCK = "infinity";
      CapabilityBoundingSet = "CAP_SYSLOG CAP_IPC_LOCK";
      AmbientCapabilities = "CAP_IPC_LOCK";
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = [ "/var/lib/vault" ];
      StateDirectory = "vault";
      StateDirectoryMode = "0700";
      UMask = "0077";
      WorkingDirectory = "/var/lib/vault";
    };
    
    environment = {
      VAULT_ADDR = "http://127.0.0.1:8200";
    };
  };

  environment.variables = {
    VAULT_ADDR = "http://127.0.0.1:8200";
  };

  # Create the data directory with proper permissions
  system.activationScripts.vault = ''
    mkdir -p /var/lib/vault/data
    chown -R vault:vault /var/lib/vault
    chmod 700 /var/lib/vault
    chmod 700 /var/lib/vault/data
  '';
}