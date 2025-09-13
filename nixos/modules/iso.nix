{ pkgs, ... }:
{
  imports = [
    ./base.nix
    ./packages.nix
    ./kanata.nix
  ];

  networking.hostName = "iso";

  services.openssh = {
      enable = true;
      banner = "haii (=^ • ^=)\n";
      settings.PasswordAuthentication = true;
    };

  users.extraUsers.root.password = "nixos";
  users.extraUsers.blltrx.password = "nixos";
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
