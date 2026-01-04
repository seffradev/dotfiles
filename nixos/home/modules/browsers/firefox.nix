{ config, pkgs, username, ...  }: {
    programs = {
        firefox = {
            enable = true;
            profiles.${username} = {
                name = "Hampus Avekvist";
                search.force = true;
                search.default = "ddg";
                search.privateDefault = "ddg";
                settings = {
                    "dom.security.https_only_mode" = true;
                    "browser.download.panel.shown" = true;
                    "identity.fxaccounts.enabled" = false;
                    "signon.rememberSignons" = false;
                    "privacy.resistFingerprinting" = false;
                    "extensions.autoDisableScopes" = 0;
                };
                extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
                    ublock-origin
                    vimium-c
                    istilldontcareaboutcookies
                    onepassword-password-manager
                ];
            };
            policies = {
                DefaultDownloadDirectory = "${config.xdg.userDirs.download}";
            };
        };
    };
}
