{ pkgs, config, lib, ... }:
{
  options = {
    orca-slicer.enable =
      lib.mkEnableOption "enables orca-slicer";
  };
  
  config = lib.mkIf config.orca-slicer.enable {
    environment.systemPackages = with pkgs; [
      orca-slicer
    ];
  };
}


