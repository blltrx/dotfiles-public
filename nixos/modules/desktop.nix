{ pkgs, vars, ... }:
{
  imports = [
    ../modules/packages.nix
    ../modules/kanata.nix
    ../modules/wireguard.nix
    ../modules/cargo-alt.nix
    ../modules/yubico.nix
  ];

  powerManagement.enable = true;
  swapDevices = [{
      device = "/var/lib/swapfile";
      size = 16*1024; # 16 GB
    }];
  users.users.blltrx.extraGroups = [ "networkmanager" "wheel" "video" "dialout" "wireshark"];
  environment.sessionVariables.TODOIST_TOKEN = "${vars.keys.todoist}";
  
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

  services = {
    printing.enable = true;
    displayManager.ly.enable = true;
    pulseaudio.extraConfig = "load-module module-combine-sink";
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    udev = {
      packages = [ pkgs.power-profiles-daemon ];
      extraRules = ''
      SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
      SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
      SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_CAPACITY}=="20", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
      '';
    };
  };
 
}
