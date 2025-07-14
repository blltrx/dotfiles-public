{ config, pkgs, options, ... }:

let
  hostname = "ranger";
in {
  networking.hostName = "${hostname}";

  imports = [
    /etc/nixos/hardware-configuration.nix
    /home/blltrx/.config/nixos/${hostname}/main.nix
  ];
}
