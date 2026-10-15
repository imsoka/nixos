{ ... }:

{
  services.moonshine = {
    enable = true;
    user = "soka";
    uid = 1000;

    # Solo LAN o VPN (Tailscale, WireGuard). No exponer a internet.
    openFirewall = false;

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
