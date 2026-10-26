{ pkgs, ... }:

{
  imports =
    [
      ../../applications/base-programs.nix
    ];

    base-programs.enable = true;
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [ kdePackages.ark ];
    };

    environment.systemPackages = with pkgs; [
      thunar-archive-plugin
      thunar-volman
      thunar-vcs-plugin
      thunar-media-tags-plugin
      vscodium
      openfortivpn
      dbeaver-bin
      python3 #Codex depends on it
      chatterino7
      code-cursor
      libresprite
      nodejs
      fluidsynth
      alsa-utils
      teams-for-linux
      # Dictado por voz (tecla global vía /dev/input y uinput, ver configuration.nix)
      (callPackage ../../applications/typeless/package.nix { })
    ];
}
