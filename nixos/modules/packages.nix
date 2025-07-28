{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  ...
  # Configurable packages
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      extraPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        waybar
        wl-mirror
        pipectl
        # wf-recorder
        mako # notification daemon
        grim
        slurp
        kitty
        fuzzel
        libnotify
      ];
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
      '';
    };
    light = {
      enable = true;
      brightnessKeys.enable = false;
    };
    fish.enable = true;
    starship = {
      enable = true;
      transientPrompt.enable = true;
      transientPrompt.right = "starship module time";
      transientPrompt.left = "starship module character";
      settings = {
        add_newline = true;
        format= "$all";
        right_format="$conda$cmd_duration";
        continuation_prompt = "--> ";
        character.success_symbol = "[->](bold green)";
        character.error_symbol = "[->](bold red)";
        conda.ignore_base = true;
        cmd_duration.min_time=10000;
        localip = {
          ssh_only = true;
          disabled = false;
        };
        directory = {
          read_only = " 󰌾";
          style = "bold #F2AFFD";
        };
        git_status = {
          modified = "~";
          style = "bold #F2AFFD ";
        };
        username = {
          show_always = true;
          format = "[$ssh_symbol$user]($style)@";
          style_user = "#24ACD4";
        };
        hostname = {
          ssh_symbol = " ";
          ssh_only = false;
          format = "[$hostname $ssh_symbol]($style)";
          style = "#F2AFFD bold";
        };
      };
    };
    # droidcam.enable = true;
    firefox.enable = true;
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
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    bat.enable = true;
    # wireshark = {
    #   enable = true;
    #   dumpcap.enable = true;
    #   usbmon.enable = true;
    # };
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
    };
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
    # ungoogled-chromium
    adwaita-icon-theme
    any-nix-shell
    art
    beeper
    bluetuith
    btop
    cargo-mommy
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
    kew
    libreoffice
    mediainfo
    mpv
    muse-sounds-manager
    musescore
    ncdu
    ncspot
    neofetch
    newsboat
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
    rust-analyzer
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
