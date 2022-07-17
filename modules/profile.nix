{ lib, config, pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_5_18_hardened;
  boot.kernelParams = [
    "console=ttyAML0,115200n8"
  ];

  boot.consoleLogLevel = lib.mkDefault 7;

  boot.supportedFilesystems = lib.mkForce [ "btrfs" "vfat" "cifs" ];

  # Since 20.03, you must explicitly specify to use dhcp on an interface
  networking.interfaces.eth0.useDHCP = true;

  services.sshd.enable = true;
  services.getty.autologinUser = lib.mkDefault "root";

  networking.firewall.enable = false;
}
