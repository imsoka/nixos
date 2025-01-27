{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications/base-applications.nix
      ../../applications/cli/openfortivpn.nix
      ../../applications/graphical/teams.nix
    ];

    openfortivpn.enable = true;
    teams.enable = true;
}
