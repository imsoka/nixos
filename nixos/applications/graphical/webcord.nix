{ pkgs, config, lib, ... }:
{
  options = {
    webcord.enable = 
      lib.mkEnableOption "installs webcord";
  };

  config = lib.mkIf config.webcord.enable {
    environment.systemPackages = with pkgs; [
      webcord
    ];
  };
}

