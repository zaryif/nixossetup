{
  description = "Zaryif's Modern NixOS System Configuration with Flakes & Antigravity";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    antigravity.url = "https://github.com/Hy4ri/antigravity-flake/archive/main.tar.gz";
    antigravity.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, antigravity, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        ({ pkgs, ... }: {
          environment.systemPackages = [
            antigravity.packages.${pkgs.system}.antigravity
            antigravity.packages.${pkgs.system}.antigravity-cli
          ];
        })
      ];
    };
  };
}
