{ pkgs, config, lib, ...}:
{
  options = {
    nvidia.enable = 
      lib.mkEnableOption "enables nvidia driver";
  };

  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
