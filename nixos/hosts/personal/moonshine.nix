{ ... }:

{
  services.moonshine = {
    enable = true;
    user = "soka";
    uid = 1000;

    # Abre los puertos en el firewall local (LAN). No redirigirlos en el router.
    openFirewall = true;

    settings = {
      # El módulo por defecto apunta a /usr/bin/steam, que no existe en NixOS.
      application = [
        {
          title = "Steam Big Picture";
          command = [ "/run/current-system/sw/bin/steam" "-bigpicture" ];
        }
      ];
    };
  };
}
