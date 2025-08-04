{ config, lib, pkgs, ... }:

{
  options = {
    thunar.enable = lib.mkEnableOption "enables thunar";
  };

  config = lib.mkIf config.thunar.enable {
    services.gvfs.enable = true;
    services.tumbler.enable = true;
    programs.xfconf.enable = true;
    programs.thunar.enable = true;
    programs.thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}

