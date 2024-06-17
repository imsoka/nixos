{ config, lib, pkgs, ... }:

{
  options = {
    qflipper.enable = lib.mkEnableOption "enables qFlipper";
  };

  config = lib.mkIf config.qflipper.enable {
    environment.systemPackages = with pkgs; [
      qFlipper
    ];
  };
}
