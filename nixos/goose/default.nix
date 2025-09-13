{ pkgs, inputs, ... }:

{
  imports = [
    "${inputs.nix-mineral}/nix-mineral.nix"
    ../modules/backup-service.nix
    ../modules/base.nix
    ../modules/kanata.nix
    # ../modules/secureboot.nix
    ../modules/serve.nix
    # ../modules/wireguard.nix
    ./hardware-configuration.nix
    ./packages.nix
    ./ssh-cloudflared.nix
  ];
  networking.enableIPv6 = true; # to disable ipv6 when docker needs upgrading
  
  # ...
  
  swapDevices = [{ device = "/dev/mapper/Main-swap"; }];

  networking.hostName = "goose";

  # ... 
  
  security.sudo.execWheelOnly = true;
  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [
    "-a exit,always -F arch=b64 -S execve"
  ];

  
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  system.stateVersion = "24.11"; # REQUIRES ATTENTION

}
