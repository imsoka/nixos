{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    moonshine = {
      url = "github:hgaiser/moonshine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, moonshine }:
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
  };

  };
}
