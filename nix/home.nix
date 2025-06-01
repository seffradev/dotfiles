{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
  onePassPath = "~/.1password/agent.sock";
  sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIf0lvauxhZ0c8IeB2Gb1QFGNaacNA9z8c0Y2CJDLIXO";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.users.ha = { pkgs, ... }: {
    # Waiting for newer version of home-manager...
    # one with e.g. https://github.com/nix-community/home-manager/pull/7074
    # home.file.".ssh/authorized_keys" = {
    #   enable = true;
    #   text = sshPublicKey;
    # };

    home.packages = with pkgs; [
      _1password-cli
      _1password-gui
      audacity
      davinci-resolve
      dunst
      firefox
      hyprlock
      keymapp
      kitty
      obs-studio
      pavucontrol
      pcloud
      prismlauncher
      rofi-wayland
      spotify
      waybar
      webcord
      wireshark
      zathura
    ];

    wayland.windowManager.hyprland = {
      enable = true;
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
        "$chat" = "webcord";
        "$music" = "spotify";
        "$polkit" = "spotify";
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
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
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
          "[workspace 10 silent] $music"
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
          "$mod, mouse:272, workspace, movewindow"
          "$mod, mouse:273, workspace, resizewindow"
          "$mod, 0, workspace, 10"
          "$mod, 0, movetoworkspace, 10"
        ] ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, ${toString i}, workspace, ${toString ws}"
              "$mod, ${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9)
        );
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
          gaps_in = 10;
          gaps_out = 20;
          gaps_workspaces = 20;
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
          rounding = 16;
          rounding_power = 2;
          active_opacity = 1;
          inactive_opacity = 0.99;
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
          "float,pin,title:(^rofi.*)"
          "stayfocused,pin,title:(^rofi.*)"
          "suppressevent maximize,class:.*"
        ];
        monitor = [
          "eDP-1, preferred, 0x0, 1"
          "DP-1, preferred, 0x0, 2"
          "DP-2, preferred, 1920x0, 2"
          "HDMI-A-1, 3840x2160@60.00Hz, auto, 2"
          ", preferred, 0x-1080, 2"
        ];
        xwayland = {
          force_zero_scaling = true;
        };
      };
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

    home.sessionVariables.NIXOS_OZONE_WL = "1";

    programs = {
      kitty = {
        enable = true;
        font = {
          size = 16.0;
          name = "JetBrains Mono";
        };
        extraConfig = ''
          bold_font "JetBrains Mono Bold"
          italic_font "JetBrains Mono Italic"
          bold_italic_font "JetBrains Mono Italic Bold"
          background_opacity 0.75
          background_blur 0
        '';
      };

      ssh = {
        enable = true;
        extraConfig = ''
          Host *
              IdentityAgent ${onePassPath}
        '';
      };

      git = {
        enable = true;
        userName = "Hampus Avekvist";
        userEmail = "hampus.avekvist@hey.com";
        extraConfig = {
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
            signingKey = sshPublicKey;
          };
          init = {
            defaultBranch = "main";
          };
          rerere = {
            enabled = true;
          };
          pull = {
            rebase = true;
          };
          rebase = {
            updateRefs = true;
          };
        };
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        history.size = 10000;
        # history.file = "$HOME/.zsh_history";

        # setOptions = [
        #   "HIST_IGNORE_ALL_DUPS"
        # ];

        shellAliases = {
          update = "sudo nixos-rebuild switch";
        };

        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "thefuck"
            "z"
            "fzf"
          ];
          theme = "robbyrussell";
        };
      };
    };

    home.stateVersion = "25.05";
  };
}
