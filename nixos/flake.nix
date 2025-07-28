{
  description = "nixos config entry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    izrss.url = "github:isabelroses/izrss";
  };

  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations.teal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./teal ];
    };

    nixosConfigurations.ranger = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./ranger ];
    };

    nixosConfiguration.goose = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      # modules = [ ./goose ]; todo
    };
  };
}

