{ ... }:

{
  imports =
    [
      ../../applications/base-programs.nix
      ../../applications/gaming-programs.nix

      #Graphical
      ../../applications/graphical/dbeaver.nix
      ../../applications/graphical/google-chrome.nix
      ../../applications/graphical/google-chrome.nix
      ../../applications/graphical/anki.nix
      ../../applications/graphical/mpv.nix
      ../../applications/graphical/qbittorrent.nix

      #CLI
      ../../applications/cli/openfortivpn.nix
      ../../applications/cli/codex.nix

    ];
  base-programs.enable = true;
  gaming-programs.enable = true;
  
  #Work
  openfortivpn.enable = true;
  dbeaver.enable = true;
  google-chrome.enable = true;

  codex.enable = true;
  anki.enable = true;
  mpv.enable = true;
  qbittorrent.enable = true;

  nixpkgs.config = { allowUnfree = true; };
}
