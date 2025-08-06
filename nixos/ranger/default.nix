{
  imports = [
    ../modules/base.nix
    ../modules/desktop.nix
    ./hardware-configuration.nix
    ./ssh-cloudflared.nix
  ];
  
  networking.hostName = "ranger";

  users.users.blltrx.extraGroups = [ "networkmanager" "wheel" "video" "dialout" "wireshark"];
  
  system.stateVersion = "24.11"; # ATTENTION NEEDED
}
