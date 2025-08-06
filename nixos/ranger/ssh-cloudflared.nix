{ vars, ... }:
{
  programs.ssh.startAgent = true;
  services = { 
  fail2ban.enable = true;
    openssh = {
      enable = true;
      ports = [ 2323 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
  
    };
    cloudflared = {
      enable = true;
      tunnels = {
        ${vars.cloudflared.tunnelRanger} = {
          credentialsFile = "/home/blltrx/.cloudflared/${vars.cloudflared.tunnelRanger}.json";
          default = "http_status:404";
        };
      };
    };
  };
}
