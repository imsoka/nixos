{ pkgs, config, lib, ... }:

{
  options = {
    locales.ja-input.enable =
      lib.mkEnableOption "Enables Japanese input (kana) with fcitx5 + Mozc";
  };

  config = lib.mkIf config.locales.ja-input.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
    };
  };
}
