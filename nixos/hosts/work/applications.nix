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
      ../../applications/graphical/browsers/firefox.nix
    ];

  nixpkgs.config.allowUnfree = true;

  base-applications.enable = true;
}
