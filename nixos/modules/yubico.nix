{ pkgs , ... }:
{
  # Yubikey pam integration (.config/Yubico for keys [untracked])
  security.pam = {
    u2f = {
      enable = true;
      settings.interactive = true;
      settings.cue = true;
    };
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };

  services = {
    udev.packages = [ pkgs.yubikey-personalization];
    pcscd.enable = true;
  };
  environment.systemPackages = [
    pkgs.yubikey-manager
    pkgs.yubioath-flutter
  ];

}
