{ pkgs, ... }: {
    home.packages = with pkgs; [
        distrobox
    ];

    programs.distrobox.settings = {
        container_additional_volumes="/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro /etc/static/profiles/per-user:/etc/static/profiles/per-user:ro";
    };
}
