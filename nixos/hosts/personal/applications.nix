{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications.nix
      ./gaming-applications.nix
    ];

}
