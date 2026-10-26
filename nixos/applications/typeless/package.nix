# Typeless (https://www.typeless.com): dictado por voz con limpieza por IA.
# Se empaqueta el .deb oficial (Electron) dentro de un entorno FHS, porque
# carga muchas librerías nativas con dlopen (koffi) y llama a herramientas
# del sistema (wl-copy, wtype...). La tecla global lee /dev/input y escribe
# con /dev/uinput: el usuario necesita los grupos input y uinput.
{
  lib,
  stdenvNoCC,
  fetchurl,
  dpkg,
  buildFHSEnv,
}:

let
  pname = "typeless";
  version = "2.2.1";

  unpacked = stdenvNoCC.mkDerivation {
    pname = "${pname}-unpacked";
    inherit version;

    src = fetchurl {
      url = "https://typeless-static.com/desktop-release/Typeless-${version}-x64.deb";
      hash = "sha256-UTCzEaWOjjv1Wk4UEOD8f108AaFbnDosFhmyJPFNdrw=";
    };

    nativeBuildInputs = [ dpkg ];
    unpackPhase = "dpkg-deb -x $src .";

    # Sin chrome-sandbox SUID, Electron usa el sandbox de user namespaces
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r opt usr/share $out/
      rm $out/opt/Typeless/chrome-sandbox
      runHook postInstall
    '';
  };
in
buildFHSEnv {
  inherit pname version;

  targetPkgs = pkgs: with pkgs; [
    # Electron
    alsa-lib atk at-spi2-atk at-spi2-core cairo cups dbus expat glib gtk3
    libdrm libgbm libGL libglvnd libnotify libsecret libxkbcommon mesa
    nspr nss pango systemd
    libx11 libxcb libxcomposite libxdamage libxext libxfixes libxrandr
    libxscrnsaver libxtst
    # Helpers nativos de Typeless
    ibus libpulseaudio util-linux
    # Herramientas que invoca
    acl procps wl-clipboard wtype xdg-utils
  ];

  # Sin esto la app se relanza con `sg input`, que falla dentro de bwrap
  # (setgroups no permitido). Los grupos ya vienen de la sesión.
  # La app escribe ~/.local/share/applications/typeless.desktop (manejador de
  # typeless://, para volver del login en el navegador) y el .desktop de
  # autoarranque con su propio ejecutable, que fuera del FHS no arranca. Si
  # APPIMAGE está definida usa esa ruta en su lugar: apuntarla al wrapper.
  profile = ''
    export TYPELESS_LINUX_INPUT_GROUP_READY=1
    export APPIMAGE=/run/current-system/sw/bin/typeless
  '';

  runScript = "${unpacked}/opt/Typeless/typeless";

  extraInstallCommands = ''
    mkdir -p $out/share
    cp -r ${unpacked}/share/icons $out/share/
    install -Dm644 ${unpacked}/share/applications/typeless.desktop \
      $out/share/applications/typeless.desktop
    substituteInPlace $out/share/applications/typeless.desktop \
      --replace-fail "Exec=/opt/Typeless/typeless" "Exec=$out/bin/typeless"
  '';

  meta = {
    description = "Voice dictation that turns speech into polished text";
    homepage = "https://www.typeless.com";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "typeless";
  };
}
