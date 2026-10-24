{ config, lib, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];

  boot.initrd.systemd.enable = true;

  #Plymouth configuration
  boot.plymouth.enable = true;
  boot.plymouth.theme = "lone";
  boot.plymouth.themePackages = [
    (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "lone" ]; })
  ];

  #Grub configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.gfxmodeEfi = "3440x1440";
  boot.loader.grub.default = "saved";
  boot.loader.grub.configurationLimit = 5;
}
