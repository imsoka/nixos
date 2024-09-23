{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications/base-applications.nix
      ../default/applications/gaming-applications.nix
      ../../applications/graphical/mpv.nix
      ../../applications/cli/ddev.nix
      ../../applications/graphical/cura.nix
    ];

  mpv.enable = true;
  ddev.enable = true;
  cura.enable = true;
}
