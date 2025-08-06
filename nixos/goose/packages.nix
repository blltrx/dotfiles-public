{ pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  # Configurable packages
  programs = {
    git = {
      enable = true;
      config = {
        user.email = "blltrx@roseis.gay";
        user.name = "blltrx";
        pull.rebase = true;
        init.defaultBranch = "main";
      };
    };
    bat.enable = true;
    fish.enable = true;
    starship = builtins.fromTOML (builtins.readFile ../modules/config/starship.toml);
    zoxide.enable = true;
  };

  # Misc Packages
  environment.defaultPackages = lib.mkForce [];
  environment.systemPackages = with pkgs; [
    any-nix-shell
    btop
    chezmoi
    cloudflared
    exiftool
    eza
    fastfetch
    fzf
    gitui
    helix
    mediainfo
    ncdu
    rclone
    ripgrep
    rsync
    starship
    udiskie
    udisks
    unison
    vulnix
    wget
    yazi
    yt-dlp
    zellij
    zip unzip
  ];
}
