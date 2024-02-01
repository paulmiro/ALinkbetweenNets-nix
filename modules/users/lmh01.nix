{ lib, pkgs, config, ... }:
with lib;
let cfg = config.link.users.lmh01;
in {
  options.link.users.lmh01 = { enable = mkEnableOption "activate user lmh01"; };
  config = mkIf cfg.enable {
    users.users.lmh01 = {
      isNormalUser = true;
      home = "/rz/sftp/lmh01/home";
      # extraGroups = [ "wheel" "adbusers" "audio" "plugdev" "docker" ]
      #   ++ lib.optionals config.networking.networkmanager.enable
      #   [ "networkmanager" ];
      # shell = "${pkgs.zsh}/bin/zsh";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHnB5ZsoYbWAa5ndFOngbcLz14yHwewX9Fp62cBkcpw"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZC4KwR8QrKvOgClilSOhWFh7rblPoRbvVRZ6+uVhNn"
      ];
    };
    # Note on sftp chrooting: The chroot folder must be owned by root and set to 755. Inside that folder create one or more folders owned by the user
    services.openssh.extraConfig = ''
      Match User lmh01
        ChrootDirectory /rz/sftp/%u
        ForceCommand internal-sftp
        AllowTcpForwarding no
    '';
  };
}
