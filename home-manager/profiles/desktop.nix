{ lib, pkgs, flake-self, config, system-config, ... }:
with lib; {
  imports = [ ./common.nix flake-self.homeManagerModules.xdg ];
  config = {
    # Packages to install on all desktop systems
    home.packages = with pkgs;
      [
        sshfs
        nfs-utils
        ## Basics
        hunspell
        hunspellDicts.de_DE
        # Audio
        helvum # Patchbay
        pavucontrol
        # Multimedia
        vlc
        mpv
        # Encryption
        veracrypt
        kleopatra # gpg/ pgp
        partition-manager
        # Misc
        xdg-utils
        # Editor
        libsForQt5.kate # kate
        kdiff3
        obsidian
        # Hex Editor
        hexdino # terminal vimlike hex editor
        okteta # hex editor
        # File Sync
        #syncthing-tray
        # Multimedia
        cobang # qr codes
        # Privacy
        # tor-browser-bundle-bin # compromised
        #mullvad-vpn
        mullvad-browser
        ktailctl
        # RDP
        remmina # VNC Client
        libsForQt5.krfb # kde connect virtual monitor
        libsForQt5.kpurpose # KDE share
        scrcpy # ADB screenshare
        libsForQt5.qt5.qtwebsockets
        libsForQt5.calendarsupport
        libsForQt5.konsole
        libsForQt5.yakuake
        libsForQt5.plasma-vault
        libsForQt5.plasma-disks
        libsForQt5.kfind
        ktailctl # Tailscale GUI
        # vivaldi
        bitwarden
        (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      ] ++ lib.optionals
        (system-config.nixpkgs.hostPlatform.system == "x86_64-linux") [ ];
    programs = {
      firefox.enable = true;
      yt-dlp = {
        enable = true;
        extraConfig = "--update";
        settings = { embed-thumbnail = true; };
      };
      #terminator.enable = true;
    };
    manual.html.enable = true;
    link = { code.enable = true; };

  };
}
