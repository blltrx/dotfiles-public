{ pkgs, inputs, ... }:

{
  imports = [
    ../modules/base.nix
    ../modules/serve.nix ## TODO
    ../modules/backup-service.nix
    ./hardware-configuration.nix
    ./packages.nix
    ./ssh-cloudflared.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];
  
  networking.hostName = "goose";
  users.users.blltrx.extraGroups = [ "networkmanager" "wheel" "video" "dialout" "wireshark" "jellyfin" "immich" "seafile" ];
 
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];  
  };
  
  security.sudo.execWheelOnly = true;
  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [
    "-a exit,always -F arch=b64 -S execve"
  ];

  nix.settings.allowed-users = [ " root " ];
  
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
