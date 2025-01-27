{ pkgs, lib, config, ... }:
{
  options = {
    cudatoolkit = {
      enable = lib.mkEnableOption "enables cudatoolkit";
    };
  };

  config = lib.mkIf config.cudatoolkit.enable {
    environment.systemPackages = with pkgs; [
        cudaPackages.cudatoolkit
    ];
  };
}
