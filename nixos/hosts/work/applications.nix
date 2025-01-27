{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../default/applications/base-applications.nix
      ../../applications/cli/ollama.nix
    ];

  ollama.enable = true;
}
