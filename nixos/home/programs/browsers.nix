{ pkgs, username, inputs, ...
}: {
    programs = {
        chromium = {
            enable = true;
            package  = pkgs.brave;
            # defaultSearchProviderEnabled = true;
            #defaultSearchProviderSearchURL = "https://duckduckgo.com/search?q={searchTerms}";
            #defaultSearchProviderSuggestURL = "https://duckduckgo.com/ac?q={searchTerms}&type=list";
            commandLineArgs = [
                "--enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
            ];
            extensions = [
                { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
                { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # vimium-c
                { id = "edibdbjcniadpccecjdfdjjppcpchdlm"; } # I still don't care about cookies
                { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
            ];
        };

        firefox = {
            enable = true;
            profiles.${username} = {
                name = "Hampus Avekvist";
                settings = {
                    "dom.security.https_only_mode" = true;
                    "browser.download.panel.shown" = true;
                    "identity.fxaccounts.enabled" = false;
                    "signon.rememberSignons" = false;
                };
                # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                #     ublock-origin
                #     vimium-c
                #     # onepassword-password-manager
                # ];
            };
        };
    };
}
