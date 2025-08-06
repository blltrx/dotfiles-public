{ inputs, ...}:

{
  imports = [
    ../modules/base.nix
    ../modules/desktop.nix
    ./hardware-configuration.nix
    ./ssh-cloudflared.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  hardware = {
    wirelessRegulatoryDatabase = true;
    sensor.iio.enable = false;
  };
  
  networking.hostName = "teal";
  system.stateVersion = "24.11";
  services.fwupd.enable = true;
}
