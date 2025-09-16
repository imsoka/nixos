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
    openfortivpn
    dbeaver
    google-chrome
    codex
    python3 #codex depends on it
    qbittorrent
  ];
  
  #Work
  nixpkgs.config = { allowUnfree = true; };
}
