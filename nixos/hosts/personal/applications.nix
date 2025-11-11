{ pkgs, ... }:

{
  imports =
    [
      ../../applications/base-programs.nix
      ../../applications/gaming-programs.nix
    ];
  base-programs.enable = true;
  gaming-programs.enable = true;


  environment.systemPackages = with pkgs; [
    codex
    python3 #codex depends on it
    google-chrome
    qbittorrent
    bruno
    vscodium
    openfortivpn
    dbeaver-bin
  ];
  
  #Work
  nixpkgs.config = { allowUnfree = true; };
}
