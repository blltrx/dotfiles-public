{
  description = "python script to selectivly change window transparancy in sway/i3";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShells.default = import ./default.nix { inherit pkgs system; };
          packages.default = import ./default.nix {inherit pkgs system; };
        }
      );
}
