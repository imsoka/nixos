{ pkgs, lib, config, ... }:

{
  imports = [
      ../../applications/graphical/lutris.nix
      ../../applications/graphical/steam.nix
      ../../applications/graphical/webcord.nix
  ];

  lutris.enable = true;
  steam.enable = true;
  webcord.enable = true;
}

