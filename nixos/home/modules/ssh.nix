{ lib, ...  }: {
    programs = {
        ssh = {
            enable = true;
            enableDefaultConfig = false;

            matchBlocks = {
                seffradev = lib.hm.dag.entryAfter ["*"] {
                    hostname = "10.10.10.112";
                    user = "ha";
                    port = 22;
                };

                "*" = lib.hm.dag.entryAfter [
                    "seffradev"
                    "skutt"
                    "skutt-filter"
                ] {
                    identityAgent = "~/.1password/agent.sock";
                    setEnv = {
                        TERM = "xterm-256color";
                    };
                };
            };
        };
    };
}
