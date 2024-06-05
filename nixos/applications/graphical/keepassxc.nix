{ pkgs, config, lib, ... }:
{
  options = {
    keepassxc.enable =
      lib.mkEnableOption "enables keepassxc";
  };
  
  config = lib.mkIf config.keepassxc.enable {
    environment.systemPackages = with pkgs; [
      keepassxc
    ];
  };
}
