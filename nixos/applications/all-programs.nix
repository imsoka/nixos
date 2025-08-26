{ lib, ... }: 

let
  # Función para encontrar todos los archivos .nix recursivamente
  findNixFiles = dir: 
    let
      entries = builtins.readDir dir;
      
      # Procesar cada entrada
      processEntry = name: type:
        let path = dir + "/${name}"; in
        if type == "directory" then
          findNixFiles path  # Recursión para subdirectorios
        else if type == "regular" && lib.hasSuffix ".nix" name then
          [ path ]  # Es un archivo .nix
        else
          [];  # Ignorar otros archivos
      
      # Aplicar a todas las entradas y aplanar resultado
      allFiles = lib.concatLists (lib.mapAttrsToList processEntry entries);
    in
      allFiles;
  
  # Encuentra archivos en directorios específicos
  cliFiles = findNixFiles ./cli;
  graphicalFiles = findNixFiles ./graphical;

  manualImports = [
    ./base-programs.nix
    ./gaming-programs.nix
  ];
  
  autoImports = cliFiles ++ graphicalFiles;

  # Combina todas las importaciones
  allImports = autoImports ++ manualImports;
  
  # Filtrar archivos que queremos excluir
  imports = builtins.filter (path: 
    let filename = builtins.baseNameOf (toString path); in
    filename != "default.nix"
  ) allImports;
in
{
  imports = imports;

  #Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
