{ pkgs, ... }:

# VPN rema (openfortivpn) sin sudo a pelo.
# - vpn-rema-up start|stop: wrapper root con host y usuario fijos (sin opciones libres).
# - La acción de polkit solo aplica a ese wrapper y pide autenticación (popup de Noctalia).
# - Contraseña VPN y OTP llegan por ficheros temporales en /run/user/<uid>/vpn-rema,
#   que el wrapper lee y borra. El plugin de Noctalia los escribe.
let
  vpnHost = "rema.icmns.net";
  vpnUser = "ogi-varaque";
  actionId = "org.nixos.vpn-rema.run";

  wrapper = pkgs.writeShellApplication {
    name = "vpn-rema-up";
    runtimeInputs = with pkgs; [ openfortivpn expect procps coreutils ];
    # SC2016: el bloque de expect usa $env(...) de Tcl a propósito, dentro de comillas simples.
    excludeShellChecks = [ "SC2016" ];
    text = ''
      action="''${1:-}"
      uid="''${PKEXEC_UID:?debe ejecutarse con pkexec}"
      dir="/run/user/$uid/vpn-rema"
      log=/run/vpn-rema.log

      case "$action" in
        start)
          pass="$dir/pass"; otp="$dir/otp"
          if [ -L "$pass" ] || [ ! -f "$pass" ]; then
            echo "falta la contraseña" >&2; exit 1
          fi
          if pgrep -x openfortivpn >/dev/null; then
            echo "ya conectada" >&2; exit 0
          fi
          # La contraseña va por variable de entorno (no en argv) y el fichero se borra ya.
          VPN_PASS="$(cat "$pass")"; export VPN_PASS
          rm -f "$pass"
          export VPN_OTP="$otp"
          # expect: envía la contraseña y, cuando pide el 2FA, espera al fichero del OTP.
          # Los patrones son una suposición: revisar con la salida real de openfortivpn.
          setsid expect -c '
            set timeout 180
            spawn openfortivpn ${vpnHost} -u ${vpnUser} --no-ftm-push
            expect {
              -re {[Pp]assword.*:} { send -- "$env(VPN_PASS)\r"; exp_continue }
              -re {[Tt]oken|[Oo]ne.?[Tt]ime|OTP|[Cc]ode.*:} {
                set code ""
                for {set i 0} {$i < 120} {incr i} {
                  if {[file exists $env(VPN_OTP)]} { set code [exec cat $env(VPN_OTP)]; exec rm -f $env(VPN_OTP); break }
                  sleep 1
                }
                send -- "$code\r"; exp_continue
              }
              eof
            }
          ' >"$log" 2>&1 &
          unset VPN_PASS
          ;;
        stop)
          pkill -INT -x openfortivpn || true
          rm -f "$dir/pass" "$dir/otp"
          ;;
        *)
          echo "uso: vpn-rema-up start|stop" >&2; exit 2 ;;
      esac
    '';
  };

  policy = pkgs.writeTextDir "share/polkit-1/actions/${actionId}.policy" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
     "http://www.freedesktop.org/standards/PolicyKit/1/policyconfig.dtd">
    <policyconfig>
      <action id="${actionId}">
        <description>Controlar la VPN rema</description>
        <message>Autentica para conectar o desconectar la VPN rema</message>
        <defaults>
          <allow_any>no</allow_any>
          <allow_inactive>no</allow_inactive>
          <allow_active>auth_self</allow_active>
        </defaults>
        <annotate key="org.freedesktop.policykit.exec.path">${wrapper}/bin/vpn-rema-up</annotate>
      </action>
    </policyconfig>
  '';
in {
  # polkit lee las acciones de share/polkit-1/actions de los paquetes del sistema;
  # pkexec pide la acción y el popup lo muestra el agente de Noctalia.
  environment.systemPackages = [ wrapper policy ];
}
