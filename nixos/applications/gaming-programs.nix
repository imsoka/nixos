{ lib, config, ... }:

{
  imports = [
      ./graphical/lutris.nix
      ./graphical/steam.nix
      ./graphical/webcord.nix
  ];

  options = {
    gaming-programs.enable = lib.mkEnableOption "enables gaming programs";
  };


  config = lib.mkIf config.gaming-programs.enable {
    lutris.enable = true;
    steam.enable = true;
    webcord.enable = true;
  };
}

