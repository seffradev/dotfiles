{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    self.submodules = true;

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nur,
      minimal-tmux,
      stylix,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        tpt14-g3 =
          let
            specialArgs = { inherit inputs; };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              nur.modules.nixos.default
              stylix.nixosModules.stylix
              ./configuration.nix
              ./tpt14-g3

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.ha = import ./home.nix;
              }
            ];
          };

        seffradev =
          let
            specialArgs = { inherit inputs; };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              nur.modules.nixos.default
              stylix.nixosModules.stylix
              ./configuration.nix
              ./seffradev

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.ha = import ./home.nix;
              }
            ];
          };
      };
    };
}
