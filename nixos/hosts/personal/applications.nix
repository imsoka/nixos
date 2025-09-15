{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../../applications/all-programs.nix
    ];
  base-programs.enable = true;
  gaming-programs.enable = true;
  
  #Work
  openfortivpn.enable = true;
  dbeaver.enable = true;
  forge-mtg.enable = true;

  anki.enable = true;
  mpv.enable = true;
  thunar.enable = true;
  libreoffice.enable = true;
  qbittorrent.enable = true;
  google-chrome.enable = true;
}
