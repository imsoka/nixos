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

  # Carátula de Pegasus en Moonlight (portada vertical 600x900) con el logo
  # oficial del proyecto
  pegasusLogo = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/mmatyas/pegasus-frontend/becf2e8b835abd876c0fa0c6274bc13acf71027e/etc/branding/logo.svg";
    hash = "sha256-qhuGdX9atojqgNb+OJhdMBbrc6poLP6Nr14ArcbQSHE=";
  };
  pegasusBoxart = pkgs.runCommand "pegasus-boxart.png" {
    nativeBuildInputs = [ pkgs.imagemagick pkgs.librsvg ];
  } ''
    fonts=${pkgs.dejavu_fonts}/share/fonts/truetype
    rsvg-convert -w 380 -h 380 ${pegasusLogo} -o logo.png
    magick -size 600x900 gradient:'#f4f4f6-#d9d9de' \
      logo.png -gravity center -geometry +0-90 -composite \
      -font $fonts/DejaVuSans-Bold.ttf -fill '#1d1d22' -pointsize 88 \
      -annotate +0+190 'Pegasus' \
      -fill '#ff4b4b' -draw 'rectangle 240,700 360,705' \
      -font $fonts/DejaVuSans.ttf -fill '#55555e' -pointsize 28 \
      -annotate +0+300 'Steam · Epic · GOG · Amazon' \
      $out
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
      application = [
        {
          # Biblioteca de Steam y Heroic generada por pegasus-library. Pasa
          # por el wrapper de home-manager, que sincroniza antes de abrir
          title = "Pegasus";
          boxart = "${pegasusBoxart}";
          command = [ "/home/soka/.nix-profile/bin/pegasus-fe" ];
          pre_command = [ [ "${closeDesktopSteam}" ] ];
        }
      ];
    };
  };
}
