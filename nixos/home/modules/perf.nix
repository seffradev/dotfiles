{ pkgs, ...  }: {
    home.packages = with pkgs; [
        tracy
        samply
    ];
}