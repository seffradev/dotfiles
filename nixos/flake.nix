{
    description = "HA's Nix configuration";
    nixConfig = { };

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

        self.submodules = true;

        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
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
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        nur,
        minimal-tmux,
        ...
    } @inputs: {
        nixosConfigurations = {
            tpt14g3 = let
                username = "ha";
                specialArgs = {inherit username; inherit inputs;};
            in nixpkgs.lib.nixosSystem {
                inherit specialArgs;
                system = "x86_64-linux";

                modules = [
                    ./hosts/tpt14g3
                    ./users/${username}/nixos.nix

                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;

                        home-manager.extraSpecialArgs = inputs // specialArgs;
                        home-manager.users.${username} = import ./users/${username}/home.nix;
                    }
                ];
            };

            seffradev = let
                username = "ha";
                specialArgs = {inherit username; inherit inputs;};
            in nixpkgs.lib.nixosSystem {
                inherit specialArgs;
                system = "x86_64-linux";

                modules = [
                    nur.modules.nixos.default
                    ./hosts/seffradev
                    ./users/${username}/nixos.nix

                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;

                        home-manager.extraSpecialArgs = inputs // specialArgs;
                        home-manager.users.${username} = import ./users/${username}/home.nix;
                    }
                ];
            };
        };
    };
}
