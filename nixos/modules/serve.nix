## Serves IMMICH, COCKPIT, BLOCKY, MINECRAFT SERVCE, JELLYFIN, SEAFILE
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
  users.users.immich.extraGroups = [ "video" "render" ];

  services = {
    immich = { # TODO REQUIRES ATTENTION https://diogotc.com/blog/immich-docker-to-nixos/
      enable = true;
      port = 2383;
      # mediaLocation = "todo"; # TODO
      openFirewall = true;
      # secretsFile = "path"; # TODO
      accelerationDevices = null;
      settings = {
        server.externalDomain = "http://immich.bellatrix.dev";
        # TODO
      };
    };

    blocky = { # or setup docker to use PIHOLE (very tempted bc omg just give me a pretty web ui (also more configurable))
      enable = true;
      settings = {
        ports.dns = 53;
          upstreams.groups.default = [
          "https://one.one.one.one/dns-query"
        ];
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = [ "1.1.1.1" "1.0.0.1" ];
        };
        blocking.blackLists.ads = [
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
        ];
        clientGroupsBlock.default = [ "ads" ];
        caching = {
          minTime = "5m";
          maxTime = "30m";
          prefetching = true;
        };
      };
    };

    minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;
      declarative = true;
      serverProperties = {
        difficulty = 3;
        gamemode = 1;
        motd = "";
        allow-cheats = true;
      };
      jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
    };

    seafile = {
      enable = true;
      adminEmail = "blltrx@roseis.gay";
      initialAdminPassword = "changeme";
      ccnetSettings.General.SERVICE_URL = "https://seafile.example.com";
      seafileSettings = {
        gc.enable = true;
        history.keep_days = "14";
        fileserver.host = "unix:/run/seafile/server.sock";
      };
    };

    cockpit = {
      enable = true;
      openFirewall = true;
    };

    jellyfin = { # TODO might need to troubleshoot hardware encoding
      enable = true;
      openFirewall = true;
    };
  };
}
