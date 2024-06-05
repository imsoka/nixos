{ pkgs, config, ... }:
{
  imports = [ ../../drivers/video/nvidia.nix ];

  nvidia.enable = true;
}
