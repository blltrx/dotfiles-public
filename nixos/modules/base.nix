{ pkgs, ... }:
{
  imports = [
    ../modules/secureboot.nix
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  networking = {
    wireless.iwd.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  users.users.blltrx = {
    isNormalUser = true;
    shell = pkgs.fish;
  };

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    EDITOR = "hx";
  };

  services = {
    udisks2.enable = true;
    xserver.xkb = {
      layout = "gb";
      variant = "";
    };
  };

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "1 hour";
    };
  };
}
