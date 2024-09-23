{ pkgs, config, lib, ... }:
{
  options = {
    prusa-slicer.enable =
      lib.mkEnableOption "enables prusa-slicer";
  };
  
  config = lib.mkIf config.prusa-slicer.enable {
    environment.systemPackages = with pkgs; [
      prusa-slicer
    ];
  };
}

