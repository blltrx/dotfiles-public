{ config, pkgs, inputs, ... }:

{
  imports = [
    ../modules/packages.nix
    ../modules/kanata.nix
    ../modules/secureboot.nix
    # ../modules/wireguard.nix
    ./ssh-cloudflared.nix
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "teal";
    wireless.iwd.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  environment.etc."xdg/user-dirs.defaults".text = ''
    DESKTOP=Desktop
    DOCUMENTS=Documents
    DOWNLOAD=Downloads
    MUSIC=Music
    PICTURES=Pictures
    PUBLICSHARE=Public
    TEMPLATES=Templates
    VIDEOS=Videos
  '';

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  console.keyMap = "uk";

  users.users.blltrx = {
    isNormalUser = true;
    shell = pkgs.fish;
    ...
    # packages = with pkgs; [];
  };
  
  environment.sessionVariables = rec {
    QT_QPA_PLATFORM = "wayland;xcb";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    ...
  };

  hardware = {
    # graphics.extraPackages = with pkgs; [ mesa.opencl ];
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  ...

  services = {
    ...
    udisks2.enable = true;
    displayManager.ly.enable = true;
    power-profiles-daemon.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    pulseaudio.extraConfig = "load-module module-combine-sink";
    udev = {
      packages = [
        pkgs.power-profiles-daemon
      ];
      extraRules = ''
      SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
      SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
      SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_CAPACITY}=="20", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
      '';
    };
  };
  
  system.stateVersion = "24.11";
}
