{pkgs, config, lib, ...}:
{
  imports = 
    [
      ../../locales/es.nix
      ../../locales/ja-input.nix
    ];

  #Enables ES locale
  locales.es.enable = true;

  #Enables kana input (fcitx5 + Mozc)
  locales.ja-input.enable = true;
}
