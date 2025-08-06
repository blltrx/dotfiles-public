{ pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;
    config.common.default = [ "gtk" "hyprland" "wlr" ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  };

  # Configurable packages
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      extraPackages = with pkgs; [
        fuzzel
        grim
        kitty
        libnotify
        mako
        pipectl
        slurp
        swayidle
        swaylock
        waybar
        wl-clipboard
        wl-mirror
      ];
      extraSessionCommands = ''
        export MOZ_ENABLE_WAYLAND=1
        export NIXOS_OZONE_WL=1
        export QT_QPA_PLATFORM=wayland
        export QT_QPA_PLATFORM=wayland;xcb
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export SDL_VIDEODRIVER=wayland
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };
    starship = builtins.fromTOML (builtins.readFile config/starship.toml);
    git = {
      enable = true;
      config = {
        user.email = "blltrx@roseis.gay";
        user.name = "blltrx";
        pull.rebase = true;
        init.defaultBranch = "main";
      };
    };
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    };
    wireshark = {
      enable = true;
      usbmon.enable = true;
    };
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
    };
    bat.enable = true;
    droidcam.enable = true;
    firefox.enable = true;
    fish.enable = true;
    light.enable = true;
    zoxide.enable = true;
  };
  
  # Fonts
  fonts.packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      noto-fonts
      noto-fonts-emoji
      comic-mono
    ];

  # Misc Packages
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    any-nix-shell
    art
    beeper
    bluetuith
    btop
    chezmoi
    cloudflared
    discord
    exiftool
    eza
    fastfetch
    feh
    framework-tool
    fzf
    gimp3
    gitui
    glow
    gnome-characters
    helix
    indicator-application-gtk3
    inputs.izrss.packages."${pkgs.system}".default
    kew
    libreoffice
    mediainfo
    mpv
    muse-sounds-manager
    musescore
    ncdu
    ncspot
    newsboat
    nil
    nmap
    playerctl
    prismlauncher
    pulseaudio
    pulsemixer
    pyright
    python313Packages.bpython
    qrrs
    rclone
    ripgrep
    shotcut
    signal-desktop
    snapshot
    spotify
    starship
    tinymist
    typos-lsp
    typst
    udiskie
    udisks
    unison
    wget
    xwayland
    yaru-theme
    yazi
    yt-dlp
    zathura
    zellij
    zip unzip
  ];
}
