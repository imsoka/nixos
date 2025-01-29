{ pkgs, config, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  services.open-webui = {
    enable = true;
  };

  services.comfyui = {
    enable = true;
    package = pkgs.comfyui;
    host = "0.0.0.0";
    models = builtins.attrValues pkgs.nixified-ai.models;
    customNodes = with comfyui.pkgs; [
      comfyui-gguf
      comfyui-impact-pack
    ];
  };
}
