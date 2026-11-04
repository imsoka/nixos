{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    moonshine = {
      url = "github:hgaiser/moonshine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NixOS dentro de WSL2 (host sokix-wsl)
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, moonshine, nixos-wsl }:
  let
    system = "x86_64-linux";
    
    pkgs = import nixpkgs {
      inherit system;
      
      config = {
        allowUnfree = true;
      };
    };

  in
  {

  nixosConfigurations = {
    sokix = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system moonshine; };

      modules = [
        moonshine.nixosModules.default
        ./nixos/hosts/personal/configuration.nix
      ];
    };

    sokix-work = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system; };

      modules = [
        ./nixos/hosts/work/configuration.nix
      ];
    };

    # Portátil del trabajo con Windows: NixOS dentro de WSL2
    sokix-wsl = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system; };

      modules = [
        nixos-wsl.nixosModules.default
        ./nixos/hosts/wsl/configuration.nix
      ];
    };
  };

  };
}
