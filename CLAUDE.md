# NixOS (flake)

Host = `hostname`: `sokix` → `nixos/hosts/personal/`, `sokix-work` → `nixos/hosts/work/`, `sokix-wsl` → `nixos/hosts/wsl/` (NixOS-WSL en el portátil con Windows; solo terminal). Cada host entra por su `configuration.nix` e importa sus módulos.

## Dónde vive cada cosa
- Paquetes comunes → `nixos/applications/base-programs.nix` (lo importan ambos hosts).
- Gaming (steam, gamescope, gamemode, discord, pegasus, input-remapper) → `nixos/applications/gaming-programs.nix`, solo personal; paquetes propios en `nixos/applications/<nombre>/package.nix`.
- Moonshine (streaming) → `hosts/personal/moonshine.nix`; tailscale → `hosts/personal/tailscale.nix`; WoL → `hosts/personal/configuration.nix`.
- Escritorio de sistema (niri, greetd, plymouth) → `hosts/<host>/graphical-environment.nix` y `boot.nix`. La config de niri del usuario está en home-manager.
- Nvidia → `nixos/drivers/video/nvidia.nix`; IA y huella → solo work (`ia.nix`, `configuration.nix`).

## sokix-wsl (NixOS-WSL)
- Input `nixos-wsl` del flake; sin `hardware-configuration.nix` (la plataforma va en `nixpkgs.hostPlatform`). `sudo` sin contraseña (por defecto en NixOS-WSL).
- La parte de Windows (apps winget, GlazeWM, Windows Terminal, `install.ps1`) está en `windows/` del repo home-manager.
- Primer arranque, tras `install.ps1` (la imagen entra con el usuario `nixos`):
  1. Dentro de WSL: `export NIX_CONFIG="experimental-features = nix-command flakes"`, `nix-shell -p git --run "git clone https://github.com/imsoka/nixos /tmp/nixos"` y `sudo -E nixos-rebuild boot --flake /tmp/nixos#sokix-wsl`.
  2. En PowerShell (cambio de usuario a `soka`): `wsl -t NixOS`, `wsl -d NixOS --user root exit`, `wsl -t NixOS`.
  3. Ya como `soka`: clonar `nixos` y `home-manager` en `~/.config/`, `git config core.hooksPath .githooks` en ambos, y `home-manager switch --flake ~/.config/home-manager#soka-wsl`.
- Trabaja en `~` (ext4 de WSL), no en `/mnt/c`: el acceso a ficheros de Windows es mucho más lento.

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
