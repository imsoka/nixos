{ pkgs, ... }:

{
  imports =
    [
      ../../applications/base-programs.nix
    ];

    base-programs.enable = true;
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [ thunar-archive-plugin thunar-volman thunar-vcs-plugin thunar-media-tags-plugin ];
    };

    environment.systemPackages = with pkgs; [
      codex
      vscodium
      openfortivpn
      dbeaver-bin
      python3 #Codex depends on it
      chatterino7
      code-cursor
      libresprite
    ];
}
