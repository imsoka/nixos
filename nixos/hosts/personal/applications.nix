{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications/base-applications.nix
      ../default/applications/gaming-applications.nix
      ../../applications/graphical/mpv.nix
      ../../applications/graphical/libreoffice.nix
      ../../applications/cli/ddev.nix
      ../../applications/cli/ventoy.nix
      ../../applications/graphical/thunar.nix
      ../../applications/graphical/orca-slicer.nix
      ../../applications/graphical/minecraft.nix
    ];

  mpv.enable = true;
  ddev.enable = true;
  thunar.enable = true;
  ventoy.enable = true;
  minecraft.enable = true;
  libreoffice.enable = true;
  orca-slicer.enable = true;
}
