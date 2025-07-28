{ config, pkgs, ... }:
{
  programs.ssh.startAgent = true;
  services = { 
    fail2ban.enable = true;
    openssh = {
      enable = true;
      ...
      settings = {
        PasswordAuthentication = false;
        UseDns = true;
        PermitRootLogin = "no";
      };
    };
    cloudflared = {
      enable = true;
      tunnels = {
        ...
        };
      };
    };
  };
}
