{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
