{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications/base-applications.nix
      ../default/applications/gaming-applications.nix
      ../../applications/graphical/mpv.nix
      ../../applications/graphical/libreoffice.nix
      ../../applications/cli/ddev.nix
      ../../applications/graphical/orca-slicer.nix
    ];

  mpv.enable = true;
  ddev.enable = true;
  libreoffice.enable = true;
  orca-slicer.enable = true;
}
