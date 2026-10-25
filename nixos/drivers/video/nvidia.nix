{ pkgs, config, lib, ...}:
{
  options = {
    nvidia.enable = 
      lib.mkEnableOption "enables nvidia driver";
  };

  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    # Early KMS: without this, greetd starts before nvidia-drm and fails on simpledrm's card0
    boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

    hardware.graphics = {
      enable = true;
    };

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      forceFullCompositionPipeline = true;
    };
  };
}
