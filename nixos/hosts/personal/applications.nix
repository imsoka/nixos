{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../../applications/packs/base-applications.nix
      ../../applications/graphical/lutris.nix
      ../../applications/graphical/qflipper.nix
      ../../applications/graphical/steam.nix
      ../../applications/graphical/webcord.nix
      ../../applications/graphical/gparted.nix
      ../../applications/graphical/alacritty.nix
      ../../applications/graphical/libreoffice.nix
    ];

  nixpkgs.config.allowUnfree = true;

  base-applications.enable = true;
  firefox.enable = true;
  lutris.enable = true;
  steam.enable = true;
  webcord.enable = true;
  gparted.enable = true;
  libreoffice.enable = true;
  qflipper.enable = true;
}
