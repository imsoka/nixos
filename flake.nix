{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixified-ai.url = "github:matthewcroughan/nixified-ai";
  };

  outputs = { self, nixpkgs, nixified-ai }: 
  let
    system = "x86_64-linx";
    
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
      specialArgs = { inherit system; };

      modules = [
        nixified-ai.nixosModules.comfyui
        ./nixos/hosts/personal/configuration.nix
      ];
    };
  };

  };
}
