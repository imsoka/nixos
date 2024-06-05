{ pkgs, config, lib, ... }:
{
  options = {
    lutris.enable = 
      lib.mkEnableOption "installs lutris";
  };

  config = lib.mkIf config.lutris.enable {
    environment.systemPackages = with pkgs; [
      wine
      lutris
    ];
  };
}
