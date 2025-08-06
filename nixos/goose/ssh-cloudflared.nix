{ vars, ... }:
{
  programs.ssh.startAgent = true;
  services = { 
    fail2ban.enable = true;
    openssh = {
      enable = true;
      ports = [ 2323 ];
      allowSFTP = false;
      banner = "haii (=^ • ^=)";
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
      extraConfig = ''
        AllowTcpForwarding yes
        X11Forwarding no
        AllowAgentForwarding no
        AllowStreamLocalForwarding no
        AuthenticationMethods publickey
      '';
    };
    cloudflared = {
      enable = true;
      tunnels = {
        ${vars.cloudflared.tunnelGoose} = {
          credentialsFile = "/home/blltrx/.cloudflared/${vars.cloudflared.tunnelGoose}.json";
          default = "http_status:404";
        };
      };
    };
  };
}
