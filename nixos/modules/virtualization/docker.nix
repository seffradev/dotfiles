{ ... }: {
    virtualisation.docker.enable = true;

    # systemd.services.docker.environment = {
    #     HTTP_PROXY  = "http://192.168.1.1:80";
    #     HTTPS_PROXY = "http://192.168.1.1:80";
    #     NO_PROXY    = "src.leissner.se,confluence.leissner.se,jira.leissner.se";
    # };
}
