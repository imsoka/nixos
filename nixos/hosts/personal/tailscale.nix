{ ... }:

# Tailscale para usar Moonshine desde fuera de casa: Moonlight se conecta a la
# IP de Tailscale del PC (100.x.y.z o sokix por MagicDNS). Los puertos de
# Moonshine ya están abiertos en el firewall (moonshine.nix) y no se
# redirigen en el router, así que solo llegan desde la LAN y desde Tailscale.
#
# La primera vez: sudo tailscale up (da un enlace para iniciar sesión).
{
  services.tailscale = {
    enable = true;
    # Abre el puerto UDP de WireGuard (41641): con él los dispositivos se
    # conectan directamente en vez de por los relés de Tailscale, que añaden
    # latencia
    openFirewall = true;
  };
}
