{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim.url = "github:nix-community/nixvim";
    hyprland.url = "github:hyprwm/Hyprland";     
    swww.url = "github:LGFae/swww";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };

    # Shell
    caelestia = {
      url = "github:caelestia-dots/shell/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, grub2-themes, ... }@inputs: {
    nixosConfigurations.Dreamer = nixpkgs.lib.nixosSystem {  # Changed to match hostname
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        grub2-themes.nixosModules.default

        {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
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
