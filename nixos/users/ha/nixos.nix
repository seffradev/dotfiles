{ pkgs, ... }: {
    users.users.ha = {
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIf0lvauxhZ0c8IeB2Gb1QFGNaacNA9z8c0Y2CJDLIXO"
        ];
    };
}
