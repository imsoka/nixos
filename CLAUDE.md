# NixOS (flake)

Host = `hostname`: `sokix` → `nixos/hosts/personal/`, `sokix-work` → `nixos/hosts/work/`. Cada host entra por su `configuration.nix` e importa sus módulos.

## Dónde vive cada cosa
- Paquetes comunes → `nixos/applications/base-programs.nix` (lo importan ambos hosts).
- Gaming (steam, gamescope, gamemode, discord, pegasus, input-remapper) → `nixos/applications/gaming-programs.nix`, solo personal; paquetes propios en `nixos/applications/<nombre>/package.nix`.
- Moonshine (streaming) → `hosts/personal/moonshine.nix`; tailscale → `hosts/personal/tailscale.nix`; WoL → `hosts/personal/configuration.nix`.
- Escritorio de sistema (niri, greetd, plymouth) → `hosts/<host>/graphical-environment.nix` y `boot.nix`. La config de niri del usuario está en home-manager.
- Nvidia → `nixos/drivers/video/nvidia.nix`; IA y huella → solo work (`ia.nix`, `configuration.nix`).

## Aplicar
1. Ficheros nuevos: `git add` antes de compilar, o el flake no los ve.
2. Compila tú: `nixos-rebuild build --flake ~/.config/nixos#<host>`.
3. El switch requiere sudo con contraseña (decisión del usuario: sin NOPASSWD). Pide al usuario que ejecute `! sudo nixos-rebuild switch --flake ~/.config/nixos#<host>` y espera su resultado.

## Hook de pre-commit
`.githooks/pre-commit` valida sintaxis y evaluación de todas las configs del flake; tras clonar actívalo con `git config core.hooksPath .githooks`.

## Commits (permiso permanente)
Commitea cada cambio ya aplicado y comprobado: un commit por tema, mensaje `tema: descripción` en español (temas habituales: `gaming`, `moonshine`, `base`, `personal`, `work`, `nvidia`, `flake`). Añade solo los ficheros que has tocado tú en esta sesión; lo que ya estaba modificado al empezar viene de otra sesión o del usuario y se queda fuera.

## Imágenes
Antes de leer capturas grandes con Read, redúcelas (p. ej. `ffmpeg -i in.png -vf scale=1280:-1 out.png`; ImageMagick no está instalado, usa `nix run nixpkgs#imagemagick` si lo necesitas).
