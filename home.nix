{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  browser = [ "zen.desktop" ];
  audio = [ "mpv.desktop" ];
  video = [ "mpv.desktop" ];
  image = [ "imv.desktop" ];
  document = [ "org.pwmt.zathura.desktop" ];
  editor = [ "nvim.desktop" ];

  firefox-extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  firefox-prefs = {
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
    "dom.security.https_only_mode" = true;
    "browser.download.panel.shown" = true;
    "identity.fxaccounts.enabled" = false;
    "signon.rememberSignons" = false;
    "privacy.resistFingerprinting" = false;
  };

  firefox-extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (firefox-extension "ublock-origin" "uBlock0@raymondhill.net")
    (firefox-extension "vimium-c" "vimium-c@gdh1995.cn")
    (firefox-extension "istilldontcareaboutcookies" "idcac-pub@guus.ninja")
    (firefox-extension "1password-x-password-manager" "{d634138d-c276-4fc8-924b-40a0ea21d284}")
  ];
in
{
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 172;
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        max_line_width = 120;
        indent_style = "space";
        indent_size = 4;
      };
    };
  };

  services = {
    kdeconnect.enable = true;
    playerctld.enable = true;
  };

  home = {
    username = "ha";
    homeDirectory = "/home/ha";

    stateVersion = "25.05";

    shellAliases = {
      e = "$EDITOR";
      rebuild = "sudo -H -E nixos-rebuild switch --flake .";
      update = "nix flake update";
      develop = "nix develop --command $SHELL";
      lg = "lazygit";
    };

    sessionVariables = {
      EDITOR = "nvim";
      PAGER = "bat";
      BROWSER = "zen";
      TERMINAL = "kitty";
      MANPAGER = "sh -c 'bat -l man -p'";
      FZF_BASE = "${pkgs.fzf}/share/fzf";
      NIXOS_OZONE_WL = "1";
    };

    packages = with pkgs; [
      python3
      grim
      slurp

      wl-clipboard
      cliphist

      waybar

      rofi
      rofi-calc
      rofimoji
      libqalculate

      hypridle
      hyprlock
      hyprpolkitagent
      hyprland-qt-support
      hyprpaper
      hyprpwcenter
      hyprpicker
      hyprsunset
      hyprpicker

      dunst

      obsidian

      imv

      abcde
      amberol
      spotify
      pavucontrol
      picard
      playerctl
      pulsemixer

      zathura

      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.sv_SE

      gh
      glab
      lazygit
      onefetch
      gnumake
      neovim
      harper
      typos
      typos-lsp
      just-lsp
      nixfmt
      nil
      emmylua-ls
      tinymist
      pyright
      ruff
      cmake-language-server
      tree-sitter
      git-filter-repo

      tracy
      termshark
      wireshark

      discord

      pcloud

      bluetuith
      rfc
      man
      bat
      fd
      ouch
      ripgrep
      yazi
      just
      btop
      cloc
      yq
      wget
      glow

      typst

      simple-scan

      (writeShellScriptBin "sniff" ''
        set -x
        FILTER="''${@:2}"
        ssh $1 -T "tshark -w - $FILTER" | wireshark -k -i -
      '')

      (pkgs.wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
        {
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList (
              name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
            ) firefox-prefs
          );

          extraPolicies = {
            DisableTelemetry = true;
            ExtensionSettings = builtins.listToAttrs firefox-extensions;
            DefaultDownloadDirectory = "${config.xdg.userDirs.download}";

            SearchEngines = {
              Default = "ddg";
              Add = [
                {
                  Name = "nixpkgs packages";
                  URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "NixOS Wiki";
                  URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@nw";
                }
                {
                  Name = "noogle";
                  URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                  IconURL = "https://noogle.dev/favicon.ico";
                  Alias = "@ng";
                }
              ];
            };
          };
        }
      )
    ];

    file = {
      "${config.xdg.configHome}/waybar/config.jsonc".source = ./waybar/config.jsonc;
      "${config.xdg.configHome}/waybar/style.css".source = ./waybar/style.css;

      "${config.xdg.configHome}/rofi/config.rasi".source = ./rofi/config.rasi;
      "${config.xdg.dataHome}/rofi" = {
        source = ./rofi/rofi-themes;
        recursive = true;
      };

      "${config.xdg.configHome}/hypr/hypridle.conf".source = ./hyprland/hypridle.conf;
      "${config.xdg.configHome}/hypr/hyprlock.conf".source = ./hyprland/hyprlock.conf;
      "${config.xdg.configHome}/hypr/hyprpaper.conf".source = ./hyprland/hyprpaper.conf;

      "${config.xdg.userDirs.pictures}/wallpapers" = {
        source = ./wallpapers;
        recursive = true;
      };

      "${config.xdg.configHome}/dunst/dunstrc".source = ./dunst/dunstrc;

      ".local/bin/tmux-sessionizer".source = ./tmux/tmux-sessionizer.sh;
      ".local/bin/cheatsheet".source = ./tmux/cheatsheet.sh;

      ".local/bin/start-gamescope".source = ./gamescope/start.sh;

      "${config.xdg.configHome}/nvim" = {
        source = ./nvim;
        recursive = true;
      };

      "${config.xdg.configHome}/clangd/config.yaml".source = ./clang/config.yaml;
      ".clang-format".source = ./clang/format.yml;

      "${config.xdg.configHome}/neomutt/templates/email.html".text = ''
        <!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" lang="$lang$" xml:lang="$lang$"$if(dir)$ dir="$dir$"$endif$>
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
          <style>
            $styles.html()$
          </style>
        $for(css)$
          <link rel="stylesheet" href="$css$" />
        $endfor$
          <!--[if lt IE 9]>
            <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv-printshiv.min.js"></script>
          <![endif]-->
        $for(header-includes)$
          $header-includes$
        $endfor$
        </head>
        <body>
          $body$
          $for(include-after)$
          $include-after$
          $endfor$
        </body>
        </html>
      '';
    };
  };

  accounts = {
    email = {
      maildirBasePath = "mail";
      accounts = {
        stsf = {
          enable = true;
          primary = false;
          neomutt.enable = true;
          mbsync = {
            enable = true;
            create = "both";
          };
          address = "sekreterare@stsf.org";
          realName = "Hampus Avekvist";
          userName = "sekreterare@stsf.org";
          passwordCommand = "op read 'op://Personal/One/password'";
          folders = {
            drafts = "Drafts";
            inbox = "Inbox";
            sent = "Sent";
            trash = "Trash";
          };
          smtp = {
            host = "send.one.com";
            port = 465;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          imap = {
            host = "imap.one.com";
            port = 993;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
        };
      };
    };
  };

  stylix = {
    targets = {
      firefox.profileNames = [ "ha" ];
    };
  };

  programs = {
    pandoc = {
      enable = true;
    };

    mbsync.enable = true;

    neomutt = {
      enable = true;
      vimKeys = true;
      sort = "reverse-date";
      sidebar = {
        enable = false;
        format = "%B%<F? [%F]>%* %<N?%N/>%S";
        shortPath = true;
        width = 25;
      };
      macros = [
        {
          key = "m";
          map = [ "compose" ];
          action = ''
            <enter-command>set pipe_decode<enter>\
            <pipe-message>pandoc -f gfm -t plain -o /tmp/msg.txt<enter>\
            <pipe-message>pandoc -s -f gfm --embed-resources --standalone -o /tmp/msg.html --resource-path ${config.xdg.configHome}/neomutt/templates/ --template email<enter>\
            <enter-command>unset pipe_decode<enter>\
            <attach-file>/tmp/msg.txt<enter>\
            <attach-file>/tmp/msg.html<enter>\
            <tag-entry><previous-entry><tag-entry><group-alternatives>\
          '';
        }
      ];
      extraConfig = ''
        unset ssl_force_tls
      '';
    };

    home-manager = {
      enable = true;
    };

    firefox = {
      enable = false;
      profiles.ha = {
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

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    kitty = {
      enable = true;
      font = {
        size = lib.mkForce 16.0;
        name = lib.mkForce "JetBrainsMono Nerd Font";
      };
      extraConfig = ''
        bold_font "JetBrainsMono Nerd Font Bold"
        italic_font "JetBrainsMono Nerd Font Italic"
        bold_italic_font "JetBrainsMono Nerd Font Italic Bold"
        background_opacity 1
        background_blur 0
      '';
    };

    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$shell"
          "$character"
        ];
        right_format = "$time";
        add_newline = false;
        package = {
          disabled = true;
        };
        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[✗](bold red) ";
        };
        time = {
          disabled = false;
          format = "[$time]($style) ";
          time_format = "%Y-%m-%d %T";
        };
        git_branch = {
          format = "[$symbol$branch(:$remote_branch)]($style) ";
          truncation_length = 17;
          truncation_symbol = "";
        };
        c = {
          detect_extensions = [
            "c"
            "h"
            "cpp"
            "hpp"
            "cxx"
            "hxx"
          ];
        };
      };
    };

    distrobox = {
      enable = true;
      settings = {
        container_additional_volumes = "/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro /etc/static/profiles/per-user:/etc/static/profiles/per-user:ro";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "viins";

      history.size = 10000;
      history.append = true;
      history.extended = true;
      history.ignoreDups = true;
      history.share = true;
      history.path = "$HOME/.zsh_history";

      dotDir = "${config.xdg.configHome}/zsh";

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "z"
          "fzf"
        ];
        theme = "robbyrussell";
      };

      initContent = lib.mkBefore ''
        if [ ! $(tty | grep tty) ] && command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
            exec tmux new -As 0
        fi

        if [[ -n "$CONTAINER_ID" ]] && ! command -v fzf >/dev/null; then
          path+=(/run/host/etc/profiles/per-user/$USER/bin /run/host/run/current-system/sw/bin)
        fi
      '';
    };

    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      historyLimit = 100000;
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      prefix = "C-f";
      plugins = with pkgs; [
        tmuxPlugins.yank
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
        { plugin = inputs.minimal-tmux.packages.${pkgs.stdenv.hostPlatform.system}.default; }
      ];
      extraConfig = ''
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
        bind-key -r i run-shell "tmux neww ~/.local/bin/cheatsheet"

        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
      '';
    };

    git = {
      enable = true;
      settings = {
        user.name = "Hampus Avekvist";
        "includeIf \"gitdir:~/projects/\"".path = "~/projects/.gitconfig";
        init = {
          defaultBranch = "main";
        };
        merge.ff = true;
        rerere = {
          enabled = true;
        };
        pull = {
          rebase = true;
        };
        rebase = {
          updateRefs = true;
          autosquash = true;
        };
        gpg = {
          format = "ssh";
        };
        "gpg \"ssh\"" = {
          program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        };
        commit = {
          gpgsign = true;
        };
        tag = {
          gpgsign = true;
        };
        user = {
          signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIf0lvauxhZ0c8IeB2Gb1QFGNaacNA9z8c0Y2CJDLIXO";
        };
        alias = {
          pr = "!f() { git fetch $1 refs/pull/$2/head:pr/$2 && git switch pr/$2; }; f";
          mr = "!f() { git fetch $1 refs/merge-requests/$2/head:mr/$2 && git switch mr/$2; }; f";
        };
        diff.tool = "nvimdiff";
        difftool.prompt = false;
        merge.tool = "nvimdiff";
        mergetool.prompt = false;
        "mergetool \"vimdiff\"".layout = "LOCAL,BASE,REMOTE / MERGED";
        "mergetool \"vimdiff\"".prompt = false;
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        debian-8gb-hel1-1 = {
          header = "Host debian-8gb-hel1-1 debian-8gb-hel1-1-tmux";
          HostName = "37.27.43.126";
          User = "root";
          Port = 22;
        };

        seffradev = {
          header = "Host seffradev seffradev-tmux";
          HostName = "10.10.10.112";
          User = "ha";
          Port = 22;
        };

        tmux = lib.hm.dag.entryAfter [ "seffradev" "debian-8gb-hel1-1" ] {
          header = "Host *-tmux";
          RequestTTY = "yes";
          RemoteCommand = "command -v tmux >/dev/null 2>&1 && exec tmux new-session -A -s main || exec $SHELL -l";
        };

        "*" =
          lib.hm.dag.entryAfter
            [
              "seffradev"
              "skutt"
              "skutt-filter"
              "debian-8gb-hel1-1"
              "tmux"
            ]
            {
              IdentityAgent = "~/.1password/agent.sock";
              SetEnv = {
                TERM = "xterm-256color";
              };
            };
      };
    };
  };

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/epub" = document;
        "application/json" = editor;
        "application/pdf" = document;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "application/xhtml+xml" = browser;
        "audio/*" = audio;
        "image/*" = image;
        "text/html" = browser;
        "text/plain" = editor;
        "video/*" = video;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/unknown" = browser;
      };
    };

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = [ "hyprland" ];
        hyprland.default = [
          "hyprland"
          "wlr"
          "gtk"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal-hyprland
      ];
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      pictures = "pictures";
      download = "downloads";
      documents = "documents";
      publicShare = "public";
      desktop = "desktop";
      music = "music";
      videos = "videos";
      templates = "templates";
      setSessionVariables = true;
      extraConfig = {
        SCREENSHOTS = "${config.xdg.userDirs.pictures}/screenshots";
      };
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        configType = "lua";
        systemd.variables = [ "--all" ];
        xwayland.enable = true;
        extraLuaFiles.user = {
          content = ./hyprland/hyprland.lua;
          autoLoad = true;
        };
      };
    };
  };
}
