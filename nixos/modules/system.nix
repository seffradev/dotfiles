{ pkgs, lib, username, ... }: {
    users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = [ "networkmanager" "wheel" "docker" ];
    };

    nix.settings = {
        trusted-users = [username];
        experimental-features = [ "nix-command" "flakes" ];
    };

    nix.gc = {
        automatic = lib.mkDefault true;
        dates  = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate = pkg: true;

    time.timeZone = "Europe/Stockholm";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "sv_SE.UTF-8";
        LC_IDENTIFICATION = "sv_SE.UTF-8";
        LC_MEASUREMENT = "sv_SE.UTF-8";
        LC_MONETARY = "sv_SE.UTF-8";
        LC_NAME = "sv_SE.UTF-8";
        LC_NUMERIC = "sv_SE.UTF-8";
        LC_PAPER = "sv_SE.UTF-8";
        LC_TELEPHONE = "sv_SE.UTF-8";
        LC_TIME = "sv_SE.UTF-8";
    };

    services.printing.enable = true;

    fonts = {
        enableDefaultPackages = false;
        fontDir.enable = true;
        packages = with pkgs; [
            # icons
            material-design-icons

            # normal fonts
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji

            # nerdfonts
            nerd-fonts.symbols-only
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
        ];

        fontconfig = {
            enable = true;
            defaultFonts = {
                emoji = ["Noto Color Emoji"];
                monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
                sansSerif = ["Noto Sans" "Noto Color Emoji"];
                serif = ["Noto Serif" "Noto Color Emoji"];
            };
        };
    };

    environment = {
        systemPackages = with pkgs; [
            gcc15
            gnumake
            nix-ld
            rustup
            vimPlugins.fzfWrapper
            vimPlugins.nvim-treesitter
        ];
    };

    virtualisation.docker.enable = true;

    security = {
        rtkit.enable = true;
        polkit.enable = true;
    };

    programs = {
        zsh.enable = true;
        nix-ld.enable = true;

        _1password.enable = true;
        _1password-gui = {
            enable = true;
            polkitPolicyOwners = [ username ];
        };

        appimage = {
            enable = true;
            binfmt = true;
        };
    };

    services = {
        xserver.xkb = {
            layout = "us";
            variant = "mac";
        };
        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
        openssh = {
            enable = true;
            openFirewall = true;
            settings = {
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
                PermitRootLogin = "no";
                X11Forwarding = true;
            };
        };
    };

    hardware.graphics.enable = true;

    boot.kernelPackages = pkgs.linuxPackages;
}
