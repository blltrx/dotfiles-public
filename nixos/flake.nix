{
  description = "nixos config entry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lanzaboote, ... }@inputs: {
    nixosConfigurations.teal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./teal
        ## Secure Boot Configuration
        lanzaboote.nixosModules.lanzaboote
      ];
    };
    nixosConfigurations.ranger = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./ranger
        ## Secure Boot Configuration
        lanzaboote.nixosModules.lanzaboote
      ];
    };
    nixosConfiguration.goose = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =[
        # todo
      ];
    };
  };
}

