{ pkgs, vars, ... }:
{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.2.0.2/32" ];
      # dns = "10.2.0.1";
      listenPort = 51820;
      privateKey = "${vars.wireguard.privKey}";
      postUp = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.2.0.2/32 -o eth0 -j MASQUERADE
        ${pkgs.iptables}/bin/ip6tables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
      '';
      preDown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.2.0.2/32 -o eth0 -j MASQUERADE
        ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
      '';

      peers = [
        {
          publicKey = "${vars.wireguard.pubKey}";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "${vars.wireguard.endpoint}";
        }
      ];
    };
  };
}
