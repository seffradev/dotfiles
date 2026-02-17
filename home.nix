{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  browser = [ "firefox.desktop" ];
  audio = [ "mpv.desktop" ];
  video = [ "mpv.desktop" ];
  image = [ "imv.desktop" ];
  document = [ "org.pwmt.zathura.desktop" ];
  editor = [ "nvim.desktop" ];
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
      BROWSER = "firefox";
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

      waybar

      rofi
      rofimoji

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

      vlc
      imv

      abcde
      amberol
      pavucontrol
      picard
      playerctl
      pulsemixer

      keymapp

      prismlauncher

      zathura

      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.sv_SE

      gh
      glab
      lazygit
      onefetch
      gcc15
      gnumake
      neovim
      harper
      typos
      typos-lsp
      just-lsp
      nixfmt
      nil

      tracy
      samply
      termshark
      wireshark

      davinci-resolve
      obs-studio
      inkscape
      audacity

      discord

      dropbox
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
      presenterm
      btop
      cloc
      yq
      wget
      glow

      typst

      (writeShellScriptBin "sniff" ''
        set -x
        FILTER="''${@:2}"
        ssh $1 -T "tshark -w - $FILTER" | wireshark -k -i -
      '')
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
      enable = true;
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
        size = 16.0;
        name = "JetBrainsMono Nerd Font";
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
        { plugin = inputs.minimal-tmux.packages.${pkgs.system}.default; }
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

      matchBlocks = {
        seffradev = lib.hm.dag.entryAfter [ "*" ] {
          hostname = "10.10.10.112";
          user = "ha";
          port = 22;
        };

        "*" =
          lib.hm.dag.entryAfter
            [
              "seffradev"
              "skutt"
              "skutt-filter"
            ]
            {
              identityAgent = "~/.1password/agent.sock";
              setEnv = {
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
        systemd.variables = [ "--all" ];
        settings = {
          "$mod" = "SUPER";
          "$terminal" = "kitty";
          "$lock" = "hyprlock";
          "$files" = "rofi -show filebrowser -normal-window";
          "$clipboard" = "cliphist list | rofi -dmenu -normal-window | cliphist decode | wl-copy";
          "$textClipboard" = "wl-paste --type text --watch cliphist store";
          "$imageClipboard" = "wl-paste --type image --watch cliphist store";
          "$bar" = "waybar";
          "$wallpaper" = "hyprpaper";
          "$password" = "1password";
          "$notifications" = "dunst";
          "$notes" = "obsidian";
          "$chat" = "discord";
          "$music" = "amberol";
          "$polkit" = "systemctl --user start hyprpolkitagent";
          "$idle" = "hypridle";
          "$screenshot" = "slurp | grim -g - - | wl-copy";
          "$drun" = "rofi -show drun -normal-window";
          "$ssh" = "rofi -show ssh -normal-window";
          "$calc" = "rofi -show calc -normal-window -no-sort -modi calc";
          "$window" = "rofi -show window -normal-window";
          "$emoji" = "rofimoji --action clipboard";
          exec = [
            "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\""
          ];
          exec-once = [
            "$bar"
            "$terminal"
            "$wallpaper"
            "$polkit"
            "$textClipboard"
            "$imageClipboard"
            "$notifications"
            "$idle"
            "[workspace 10 silent] $password"
            "[workspace 10 silent] $chat"
            "[workspace special silent] $notes"
            "[workspace special silent] $music"
          ];
          bind = [
            "$mod, ESCAPE, exit,"
            "$mod, RETURN, exec, $terminal"
            "$mod, O, exec, $lock"
            "$mod, Q, killactive"
            "$mod, E, exec, $files"
            "$mod, V, exec, $clipboard"
            "$mod, D, exec, $drun"
            "$mod, S, exec, $ssh"
            "$mod, W, exec, $window"
            "$mod, C, exec, $calc"
            "$mod, P, togglefloating"
            "$mod, P, togglegroup"
            "$mod SHIFT, E, exec, $emoji"
            ", Print, exec, $screenshot"
            "$mod SHIFT, S, exec, $screenshot"
            "$mod, R, submap, resize"
            "$mod, H, movefocus, l"
            "$mod, L, movefocus, r"
            "$mod, K, movefocus, u"
            "$mod, J, movefocus, d"
            "$mod SHIFT, H, movewindow, l"
            "$mod SHIFT, L, movewindow, r"
            "$mod SHIFT, K, movewindow, u"
            "$mod SHIFT, J, movewindow, d"
            "$mod, F, fullscreen"
            "$mod, M, togglespecialworkspace, magic"
            "$mod SHIFT, M, movetoworkspace, special:magic"
            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"
            "$mod, 0, workspace, 10"
            "$mod SHIFT, 0, movetoworkspace, 10"
          ]
          ++ (builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, ${toString ws}, workspace, ${toString ws}"
                "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          ));
          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
          bindel = [
            ", xf86monbrightnessup, exec, brightnessctl set 5%+"
            ", xf86monbrightnessdown, exec, brightnessctl set 5%-"
            ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
            ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
            ", xf86audiomute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
            ", xf86audiomicmute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
            ", xf86audioplay, exec, playerctl play-pause"
            ", xf86audioprev, exec, playerctl previous"
            ", xf86audionext, exec, playerctl next"
          ];
          bindl = [
            ", switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
            ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, preferred, 0x0, 1\""
          ];
          env = [
            "XCURSOR_SIZE,24"
            "XCURSOR_THEME,"
            "NVD_BACKEND,direct"
            "GTK_THEME,"
            "HYPRLAND_TRACE,1"
            "HYPRLAND_NO_RT,1"
            "HYPRLAND_NO_SD_NOTIFY,1"
            "HYPRLAND_NO_SD_VARS,1"
            "HYPRLAND_SIZE,24"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
            "GDK_BACKEND,wayland,x11,*"
            "SDL_VIDEODRIVER,wayland"
            "CLUTTER_BACKEND,wayland"
            "QT_QPA_PLATFORM,wayland;xcb"
            "QT_QPA_PLATFORMTHEME,qt6ct"
            "QT_AUTO_SCREEN_SCALE_FACTOR,1"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "GBM_BACKEND,nvidia-drm"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            "LIBVA_DRIVER_NAME,nvidia"
          ];
          input = {
            kb_layout = "us";
            kb_variant = "mac";
            kb_model = "";
            kb_options = "";
            kb_rules = "";
            repeat_rate = 80;
            repeat_delay = 180;
            follow_mouse = 1;
            sensitivity = 0;
            touchpad = {
              natural_scroll = true;
            };
          };
          cursor = {
            hide_on_key_press = true;
          };
          general = {
            gaps_in = 0;
            gaps_out = 0;
            gaps_workspaces = 0;
            border_size = 0;
            "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";
            resize_on_border = true;
            allow_tearing = false;
            layout = "dwindle";
          };
          binds = {
            movefocus_cycles_fullscreen = true;
          };
          decoration = {
            rounding = 0;
            rounding_power = 0;
            active_opacity = 1;
            inactive_opacity = 1;
            blur = {
              enabled = true;
              size = 3;
              passes = 1;
              vibrancy = 0.1696;
            };
          };
          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 0, 7, myBezier"
              "windowsOut, 0, 7, default"
              "border, 0, 10, default"
              "borderangle, 0, 8, default"
              "fade, 0, 7, myBezier"
              "workspaces, 0, 6, default"
            ];
          };
          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };
          master = {
            new_status = "master";
          };
          misc = {
            force_default_wallpaper = -1;
            disable_hyprland_logo = false;
          };
          windowrule = [
            "match:title ^rofi.*, float on, pin on, stay_focused on"
            "match:class .*, suppress_event maximize"
          ];
          monitor = [
            "eDP-1, preferred, 0x0, 1"
            "HDMI-A-1, 3840x2160@60.00Hz, auto, 2"
            ", 3840x2160@60.00Hz, auto, 2"
          ];
          xwayland = {
            force_zero_scaling = true;
          };
        };
        xwayland.enable = true;
        extraConfig = ''
          submap = resize
          binde = , L, resizeactive,  10   0
          binde = , H, resizeactive, -10   0
          binde = , K, resizeactive,   0 -10
          binde = , J, resizeactive,   0  10
          bind  = , escape, submap, reset
          bind  = , catchall, submap, reset
          submap = reset
        '';
      };
    };
  };
}
