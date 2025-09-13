if status is-interactive
    any-nix-shell fish --info-right | source

    abbr -a cat bat
    abbr -a ll "eza -l --icons=always"
    abbr -a l "eza -al --icons=always"
    abbr -a ls eza
    abbr -a ff fastfetch
    abbr -a todo todoist-rs
    abbr -a zj zellij
    abbr -a c clear
    abbr -a nm nmcli
    abbr -a spotify ncspot
    abbr -a typstsync "unison notes-sync -batch"
    abbr -a exip "curl https://ipv4.myexternalip.com/raw"
    abbr -a exip6 "curl https://ipv6.myexternalip.com/raw"
    abbr -a pkgsearch "nix search nixpkgs"
    abbr -a code "nix develop --command 'zellij'"
    abbr -a wifi "iwctl station wlan0"
    abbr -a rmexif "exiftool -all:all="
    abbr -a nixos-rebuild "sudo nixos-rebuild switch --flake ~/.config/nixos#(hostname)"

    if status is-login
        exec bash -c "test -e /etc/profile && source /etc/profile
\
        exec fish"
    end
end
