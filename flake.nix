{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim.url = "github:nix-community/nixvim";      

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.Dreamer = nixpkgs.lib.nixosSystem {  # Changed to match hostname
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            users.nop = import ./home.nix;
            extraSpecialArgs = { inherit inputs; };
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
