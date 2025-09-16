{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../../applications/base-programs.nix
      ../../applications/gaming-programs.nix
    ];
  base-programs.enable = true;
  gaming-programs.enable = true;
  
  #Work
  openfortivpn.enable = true;
  dbeaver.enable = true;
  google-chrome.enable = true;

  anki.enable = true;
  mpv.enable = true;
  thunar.enable = true;
  libreoffice.enable = true;
  qbittorrent.enable = true;
  forge-mtg.enable = true;
}
