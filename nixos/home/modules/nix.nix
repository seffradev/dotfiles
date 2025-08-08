{ config, pkgs, ... }: {
    home.shellAliases = {
        update = "sudo nixos-rebuild switch --flake .";
        develop = "nix develop --command $SHELL";
    };
}