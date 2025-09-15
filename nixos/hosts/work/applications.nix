{ ... }:

{
  imports =
    [
      ../../applications/base-programs.nix
      ../../applications/graphical/openfortivpn.nix
      ../../applications/graphical/dbeaver.nix
    ];

    base-programs.enable = true;

    openfortivpn.enable = true;
    dbeaver.enable = true;
}
