{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications/base-applications.nix
      ../../applications/cli/openfortivpn.nix
      ../../applications/graphical/dbeaver.nix
    ];

    openfortivpn.enable = true;
    dbeaver.enable = true;
}
