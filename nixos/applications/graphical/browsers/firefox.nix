{ pkgs, config, lib, ... }:
{
  options = {
    firefox.enable =
      lib.mkEnableOption "enables firefox";
  };
  
  config = lib.mkIf config.firefox.enable {
    programs.firefox.enable = true;
  };
}

