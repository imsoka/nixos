# Grok Bot (xAI): se empaqueta el AppImage oficial de la descarga stable de
# api2.cursor.sh (redirige a downloads.cursor.com). Para actualizar: cambia
# version, url y hash (sha256 del nuevo AppImage, en formato SRI).
{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "grok-bot";
  version = "0.78.1";

  src = fetchurl {
    url = "https://downloads.cursor.com/grokbot/stable/72e130b4e6be3fdc47b97e809b6b420908ce2dd8/linux/x64/Grok_Bot_${version}.AppImage";
    hash = "sha256-BQ11I8bvoEYmYROuLjsfPOlAlVSSwrlS/T5pi2DXP7g=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  meta = {
    description = "Grok Bot by xAI";
    homepage = "https://x.ai/bot";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
