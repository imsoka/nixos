# A2Tools DPS Meter (https://github.com/taengu/A2Tools-DPS-Meter): meter de
# AION 2 que lee el tráfico del juego con libpcap. Se empaqueta el .deb
# oficial; el permiso de captura (cap_net_raw) lo da security.wrappers.
{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  wrapGAppsHook3,
  webkitgtk_4_1,
  gtk3,
  libsoup_3,
  glib,
  cairo,
  gdk-pixbuf,
  dbus,
  libpcap,
  libayatana-appindicator,
  glib-networking,
}:

stdenv.mkDerivation rec {
  pname = "a2tools-dps-meter";
  version = "2.0.71";

  src = fetchurl {
    url = "https://github.com/taengu/A2Tools-DPS-Meter/releases/download/v${version}/a2tools-dps-meter_${version}_amd64.deb";
    sha256 = "14cfb45d9dn2cr3c9lcwspn2qwi2gzvsh39plsb9c4vj5f3r5zzs";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook wrapGAppsHook3 ];
  buildInputs = [
    webkitgtk_4_1 gtk3 libsoup_3 glib cairo gdk-pixbuf dbus glib-networking
    stdenv.cc.cc.lib
  ];
  # Se cargan con dlopen, no aparecen en las dependencias del binario
  runtimeDependencies = map lib.getLib [ libpcap libayatana-appindicator ];

  unpackPhase = "dpkg-deb -x $src .";

  # Tauri busca sus recursos en <bin>/../lib/<nombre del producto>
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r usr/bin usr/lib usr/share $out/
    substituteInPlace "$out/share/applications/A2Tools DPS Meter.desktop" \
      --replace-fail "Exec=a2tools-dps-meter" "Exec=/run/wrappers/bin/a2tools-dps-meter"
    runHook postInstall
  '';

  meta = {
    description = "AION 2 real-time DPS meter";
    homepage = "https://github.com/taengu/A2Tools-DPS-Meter";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "a2tools-dps-meter";
  };
}
