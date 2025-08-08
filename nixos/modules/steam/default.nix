{ ... }: {
    programs = {
        gamescope = {
            enable = true;
            capSysNice = true;
        };

        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
            gamescopeSession.enable = true;
        };
    };
}