{ pkgs, ... }:

{
  imports =
    [
      ../../applications/base-programs.nix
      ../../applications/gaming-programs.nix
    ];
  base-programs.enable = true;
  gaming-programs.enable = false;


  environment.systemPackages = with pkgs; [
    openfortivpn
    dbeaver-bin
    google-chrome
    codex
    python3 #codex depends on it
  ];
  
  #Work
  nixpkgs.config = { allowUnfree = true; };
}
