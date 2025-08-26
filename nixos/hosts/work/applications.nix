{ ... }:

{
  imports =
    [
      ../../applications/all-programs.nix
    ];

    base-programs.enable = true;
    calibre.enable = true;

    openfortivpn.enable = true;
    dbeaver.enable = true;
}
