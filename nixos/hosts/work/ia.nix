{ pkgs, ... }:
{
  services.ollama.enable = true;
  services.ollama.package = pkgs.ollama-cuda;

  environment.systenPackages = with pkgs; [
    openclaw
  ];
}
