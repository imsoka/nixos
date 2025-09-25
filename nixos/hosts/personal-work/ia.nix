{ ... }:

{
  services.ollama.enable = true;
  services.ollama.acceleration = "cuda";
  services.ollama.loadModels = [
    "qwen3:8b"
    "qwen3-coder:30b"
  ];

  services.open-webui.enable = true;
}
