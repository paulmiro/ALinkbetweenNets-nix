# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      ./disk-config.nix
    ];
  swapDevices = [{ device = "/.swapvol/swapfile"; }];
  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" "usbnet" ];
    kernelParams = [ "intel_pstate=active" ];
    resumeDevice = "/dev/disk/by-uuid/0022d4a1-7687-42cd-a702-f1176296ff0b";
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
      # secrets = {
      #   "/crypto_keyfile.bin" = null;
      # };
      # luks.devices = {
      #   "luks-3ad6d3e0-bab0-4e07-b33e-809fcf7cdc08" = {
      #     device = "/dev/disk/by-uuid/3ad6d3e0-bab0-4e07-b33e-809fcf7cdc08";
      #     #keyFile="/crypto_keyfile.bin";
      #     #preLVM = true;
      #     #allowDiscards = true;
      #   };
      #   "luks-7d656aba-8356-4f4f-9fe8-6fb0e12b0868" = {
      #     device = "/dev/disk/by-uuid/7d656aba-8356-4f4f-9fe8-6fb0e12b0868";
      #     #keyFile="/crypto_keyfile.bin";
      #   };
      # };
    };
  };
  # fileSystems."/" =
  #   {
  #     device = "/dev/disk/by-uuid/1afbe8e8-6799-4a57-8df3-bbd642aa3b8b";
  #     fsType = "ext4";
  #   };
  # fileSystems."/boot" =
  #   {
  #     device = "/dev/disk/by-uuid/0DF8-91F1";
  #     fsType = "vfat";
  #   };
  # swapDevices =
  #   [{ device = "/dev/disk/by-uuid/f9d9b644-cd29-4393-8f2c-670d39e596f4"; }];
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s13f0u1u4c2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.intel.updateMicrocode = true;
}
