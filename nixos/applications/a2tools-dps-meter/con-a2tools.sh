# Uso (en las opciones de lanzamiento de Steam): con-a2tools <comando...>
# Abre el A2Tools DPS Meter, lanza el juego y cierra el meter al salir. Si el
# meter ya estaba abierto lo deja como está.
#
# Va antes de steam-gamescope: dentro de gamescope el meter se abriría en su
# Xwayland en vez de en el escritorio. Sin SteamAppId para que
# steam-game-workspace no lo trate como un juego (lo redimensionaría).

meter=/run/wrappers/bin/a2tools-dps-meter

running() {
  local pid
  for pid in $(pgrep -u "$(id -u)" -f a2tools-dps-meter); do
    [[ "$(readlink "/proc/$pid/exe" 2>/dev/null)" == *-a2tools-dps-meter-*/bin/* ]] && return 0
  done
  return 1
}

meter_pid=
if ! running; then
  env -u SteamAppId -u SteamGameId -u SteamOverlayGameId -u LD_PRELOAD \
    "$meter" >/dev/null 2>&1 </dev/null &
  meter_pid=$!
fi

status=0
"$@" || status=$?

[[ -z "$meter_pid" ]] || kill "$meter_pid" 2>/dev/null || true
exit "$status"
