{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications/base-applications.nix
      ../default/applications/gaming-applications.nix
    ];
}
