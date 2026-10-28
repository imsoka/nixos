{ ... }:

# Tailscale en el portátil de trabajo. La primera vez: sudo tailscale up
# (da un enlace para iniciar sesión).
{
  services.tailscale = {
    enable = true;
    # Abre el puerto UDP de WireGuard (41641) para conexiones directas en vez
    # de por los relés de Tailscale
    openFirewall = true;
  };
}
