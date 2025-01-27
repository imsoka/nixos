{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications/base-applications.nix
      ../../applications/cli/cudatoolkit.nix
    ];

    cudatoolkit.enable = true;
}
