{ self, ... }:
{ pkgs, lib, config, flake-self, home-manager, modulesPath, ... }: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
  ];
  home-manager.users.l = flake-self.homeConfigurations.server;
  link = {
    common.enable = true;
    server.enable = true;
    # grub.enable = true;
    # systemd-boot.enable = false;
    # fs.zfs.enable = true;
    # fs.btrfs.enable = true;
    # fs.luks.enable = true;
    # fs.ntfs.enable = true;
    ##
    # vm.enable = true;
    # cpu-amd.enable = true;
    # nvidia.enable = true;
    ##
    docker.enable = true;
    fail2ban.enable = true;
    ##
    domain = "alinkbetweennets.de";
    # storage = "/rz/srv";
    # syncthingDir = "/rz/syncthing";
    # secrets = "/pwd";
    #seafile.enable = true;
    # service-ip = "10.0.1.1";
    # users.lenny.enable = true;
    # users.lmh01.enable = true;
    syncthing.enable = true;

    service-interface = "tailscale0";
    nginx.enable = false;
    nginx-expose = false;

    # containers = {
    #   grist.enable = true;
    #   diagrams.enable = true;
    # };
    # zola.enable = true;
    service-ports-expose = true;
    users.lmh01.enable = true;
    services = {
      tt-rss.enable = true;
      searx.enable = true;
      microbin.enable = true;
      mailserver.enable = true;
      cryptpad.enable = true;
      # photoprism.enable = true; # WIP
      keycloak.enable = true;
      #gitea.enable = true;
      gitlab.enable = true;
      # grafana.enable = true;
      # # seafile.enable = true;
      # # xandikos.enable = true; # WIP
      hedgedoc.enable = true;
      jellyfin.enable = true;
      # jellyseer.enable = true;
      minio.enable = true;
      immich.enable = true;
      nextcloud = {
        enable = true;
        nginx-expose = true;
      };
      # nfs.enable = true;
      outline = {
        enable = true;
        # nginx-expose = true;
        oidClientId =
          "7cec0458291c1d98c37bce1ad62ea7b02790d7330f1ce5b6a25d9da95c6b3108";
      };
      paperless.enable = true;
      vaultwarden.enable = true;
      # matrix.enable = true;
      # restic-server = { enable = true; expose = false; };
      restic-server.enable = true;
      # coturn.enable = true;
      # dns.enable = true;
      restic-client = {
        enable = true;
        backup-paths-onedrive = [
          "/home/l/.data-mirror"
          "/home/l/.ssh"
          "/home/l/archive"
          "/home/l/doc"
          "/home/l/Music"
          "/home/l/sec"
          "/home/l/Sync"
          "/home/l/uni"
          "/home/l/w"
        ];
        backup-paths-lenny-storagebox = [
          "/home/l/.data-mirror"
          "/home/l/.ssh"
          # "/home/l/archive"
          "/home/l/doc"
          "/home/l/Music"
          "/home/l/sec"
          "/home/l/Sync"
          "/home/l/uni"
          "/home/l/w"
        ];
        backup-paths-pi4b = [
          "/home/l/.ssh"
          "/home/l/archive"
          "/home/l/.data-mirror"
          "/home/l/Sync"
          "/home/l/doc"
          "/home/l/uni"
        ];
      };
      # wg-link.enable = true;
      # services.jitsi = {
      #   enable = true;
      #   expose = false;
      # };
      # keycloak.enable = true;
    };
    eth = "eth0@if146";
  };
  services.owncast = {
    enable = true;
    openFirewall = true;
    listen = "0.0.0.0";
    rtmp-port = 1935;
    port = 8888;
  };
  services.onedrive.enable = true;
  services.clamav = {
    # Antivirus
    daemon.enable = true;
    updater.enable = true;
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIELDx8vTqed3YBepK2EEcM0vsLZX3g9gxwzVknwYlAgh root@sn"
  ];

  nix.settings.auto-optimise-store = true;
  # services.cloudflare-dyndns = {
  #   ipv4 = lib.mkForce false;
  #   ipv6 = lib.mkForce false;
  # };
  # boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  networking = {
    #   firewall = {
    #     # allowedUDPPorts = [ 51821 ];
    #     # allowedTCPPorts = [ 51821 ];
    #   };
    #   nat = {
    #     enable = true;
    #     externalInterface = "tailscale0";
    #     externalIP = "100.89.178.137";
    #     internalInterfaces = [ "virbr0" ];
    #     internalIPs = [ "192.168.122.91/32" ];
    #     forwardPorts = [
    #       # { sourcePort = 41623; proto = "tcp"; destination = "192.168.122.91:22"; loopbackIPs = [ "192.168.122.1" ]; }
    #     ];
    #   };
    #   interfaces."${config.link.eth}".wakeOnLan.enable = true;
    hostName = "sn";
    domain = "monitor-banfish.ts.net";
    hostId = "007f0200";
    #   extraHosts = ''
    #     192.168.122.200 snvnarr
    #   '';
  };
  fileSystems."/home/lmh01/jellyfin-data" = {
    device = "/var/lib/jellyfin-data";
    options = [ "bind" ];
  };
  # fileSystems."/rz/sftp/lmh01/arr" = {
  #   device = "/rz/arr/";
  #   options = [ "bind" ];
  # };
  # virtualisation.oci-containers.containers.librespeedtest = {
  #   autoStart = true;
  #   image = "adolfintel/speedtest";
  #   environment = {
  #     TITLE = "sn speedtest";
  #     ENABLE_ID_OBFUSCATION = "true";
  #     WEBPORT = "8766";
  #     MODE = "standalone";
  #   };
  #   ports = [ "8766:8766/tcp" ];
  # };
  # systemd.services.docker-librespeedtest = {
  #   preStop = "${pkgs.docker}/bin/docker kill librespeedtest";
  # };
  # powerManagement.powertop.enable = true;
  # virtualisation.sharedDirectories = {
  #   arr = {
  #     source = "/rz/arr";
  #     target = "/mnt/arr";
  #   };
  # };
  # services.onedrive.enable = true;
  # boot = {
  #   # loader.grub.device = "/dev/sdd";
  #   zfs.extraPools = [ "wdp" ];
  # };
  # nix run .\#lollypops -- sn:rebuild
  lollypops.deployment = {
    # local-evaluation = true;
    ssh = {
      host = "sn";
      user = "l";
    };
    # sudo.enable = true;
    ssh.opts = [ "-p 2522" ];
    sudo.enable = true;
  };

  # Supress systemd units that don't work because of LXC.
  # https://blog.xirion.net/posts/nixos-proxmox-lxc/#configurationnix-tweak
  systemd.suppressedSystemUnits = [
    "dev-mqueue.mount"
    "sys-kernel-debug.mount"
    "sys-fs-fuse-connections.mount"
  ];

}
