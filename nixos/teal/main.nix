{ config, pkgs, ... }:

{
  imports = [
    ../packages.nix
    # REDACTED
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    # REDACTED
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

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

  # User
  users.users.blltrx = {
    isNormalUser = true;
    description = "blltrx";
    # REDACTED
    # packages = with pkgs; [];
  };

  # Set shell as fish
  users.defaultUserShell = pkgs.fish;

  # Set env var allowing recursion
  environment.sessionVariables = rec {
    # REDACTED
  };

  # Enable bluetooth
  hardware = {
    # graphics.extraPackages = with pkgs; [ mesa.opencl ];
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };


    # REDACTED
  # Services
  services = {
    # REDACTED
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
    # REDACTED
    };
  };
  
  system.stateVersion = "24.11";
}
