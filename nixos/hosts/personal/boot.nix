{ config, lib, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];

  #Plymouth configuration
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";

  boot.initrd.systemd.enable = true;

  #Grub configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.gfxmodeEfi = "3440x1440";

}
