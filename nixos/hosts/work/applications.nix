{ pkgs, ... }:

{
  imports =
    [
      ../../applications/base-programs.nix
    ];

    base-programs.enable = true;

    environment.systemPackages = with pkgs; [
      codex
      openfortivpn
      dbeaver-bin
      python3 #Codex depends on it
    ];
}
