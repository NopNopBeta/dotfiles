{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprpanel.url = "github:jas-singhfsu/hyprpanel";
      hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
      
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprpanel, ... }@inputs: {
    nixosConfigurations.nop = nixpkgs.lib.nixosSystem {  # Changed to match hostname
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        
        {
          home-manager = {
            useUserPackages = true;
            users.nop = import ./home.nix;
          };
        }

        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            inputs.hyprpanel.overlay  # Apply HyprPanel overlay
          ];
        })
      ];
    };
  };
}