{
  description = "nixos config entry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    izrss.url = "github:isabelroses/izrss";
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let vars = builtins.fromTOML (builtins.readFile ./vars.toml); in
  {

    nixosConfigurations.teal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs vars; };
      modules = [ ./teal ];
    };

    nixosConfigurations.ranger = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs vars; };
      modules = [ ./ranger ];
    };

    nixosConfigurations.goose = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs vars; };
      modules = [ ./goose ]; 
    };
  };
}

