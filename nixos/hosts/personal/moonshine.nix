{ pkgs, ... }:

let
  # Steam es de una sola instancia: con el Steam del escritorio abierto, el
  # steam:// de la sesión se le reenvía y el juego sale en el monitor del PC
  # en vez de en el stream. Se cierra antes de empezar (lo recomienda
  # Moonshine en TIPS.md); el de la sesión usa la misma cuenta, así que
  # logros y Steam Cloud funcionan igual. Si no está abierto no se llama a
  # steam -shutdown, que lo arrancaría.
  closeDesktopSteam = pkgs.writeShellScript "close-desktop-steam" ''
    PATH=${pkgs.lib.makeBinPath [ pkgs.procps pkgs.coreutils ]}
    pgrep -f 'ubuntu12_32/steam' >/dev/null || exit 0
    /run/current-system/sw/bin/steam -shutdown >/dev/null 2>&1 &
    for _ in $(seq 1 30); do
      pgrep -f 'ubuntu12_32/steam' >/dev/null || exit 0
      sleep 1
    done
  '';
in
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
          pre_command = [ [ "${closeDesktopSteam}" ] ];
        }
        {
          # Biblioteca de Steam y Heroic generada por pegasus-library. Pasa
          # por el wrapper de home-manager, que sincroniza antes de abrir
          title = "Pegasus";
          command = [ "/home/soka/.nix-profile/bin/pegasus-fe" ];
          pre_command = [ [ "${closeDesktopSteam}" ] ];
        }
      ];
    };
  };
}
