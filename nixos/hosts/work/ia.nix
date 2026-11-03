{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.callPackage ../../applications/grok-bot/package.nix { })
  ];
}
