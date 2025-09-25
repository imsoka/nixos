{pkgs, config, lib, ...}:
{
  imports = 
    [
      ../../locales/es.nix
    ];

  #Enables ES locale
  locales.es.enable = true;
}
