{
  description = "nixos config entry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    nix-mineral.url = "github:cynicsketch/nix-mineral";
    nix-mineral.flake = false;
    izrss.url = "github:isabelroses/izrss";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let vars = builtins.fromTOML (builtins.readFile ./vars.toml); in
  {
    nixosConfigurations = {

      teal = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs vars; };
        modules = [ ./teal ];
      };

      ranger = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs vars; };
        modules = [ ./ranger ];
      };

      goose = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs vars; };
        modules = [ ./goose ]; 
      };
  
      iso = nixpkgs.lib.nixosSystem {
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
          "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          ./modules/iso.nix
        ];
        specialArgs = { inherit inputs; };
      };

    };
  };
}

