------------------
---- PROGRAMS ----
------------------

local mod = "SUPER"

local terminal = "kitty"
local lock = "hyprlock"
local files = "rofi -show filebrowser -normal-window"
local clipboard = "cliphist list | rofi -dmenu -normal-window | cliphist decode | wl-copy"
local textClipboard = "wl-paste --type text --watch cliphist store"
local imageClipboard = "wl-paste --type image --watch cliphist store"
local bar = "waybar"
local wallpaper = "hyprpaper"
local password = "1password"
local notifications = "dunst"
local notes = "obsidian"
local chat = "discord"
local music = "spotify"
local polkit = "systemctl --user start hyprpolkitagent"
local idle = "hypridle"
local screenshot = "slurp | grim -g - - | wl-copy"
local drun = "rofi -show drun -normal-window"
local ssh = "rofi -show ssh -normal-window"
local calc = "rofi -show calc -normal-window -no-sort -modi calc"
local window = "rofi -show window -normal-window"
local emoji = "rofimoji --action clipboard"

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60.00", position = "auto", scale = 2 })
hl.monitor({ output = "DP-1", mode = "3840x2160@60.00", position = "0x0", scale = 2 })
hl.monitor({ output = "DP-2", mode = "3840x2160@60.00", position = "1920x0", scale = 2 })
hl.monitor({ output = "", mode = "3840x2160@60.00", position = "auto", scale = 2 })

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "")
hl.env("NVD_BACKEND", "direct")
hl.env("GTK_THEME", "")
hl.env("HYPRLAND_TRACE", "1")
hl.env("HYPRLAND_NO_RT", "1")
hl.env("HYPRLAND_NO_SD_NOTIFY", "1")
hl.env("HYPRLAND_NO_SD_VARS", "1")
hl.env("HYPRLAND_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")

-------------------
---- AUTOSTART ----
-------------------

-- Was `exec`: runs on start and on every config reload
local function setColorScheme()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"")
end

hl.on("config.reloaded", setColorScheme)

-- Was `exec-once`
hl.on("hyprland.start", function ()
    setColorScheme()

    hl.exec_cmd(bar)
    hl.exec_cmd(terminal)
    hl.exec_cmd(wallpaper)
    hl.exec_cmd(polkit)
    hl.exec_cmd(textClipboard)
    hl.exec_cmd(imageClipboard)
    hl.exec_cmd(notifications)
    hl.exec_cmd(idle)

    hl.exec_cmd(password, { workspace = "10 silent" })
    hl.exec_cmd(chat, { workspace = "10 silent" })
    hl.exec_cmd(notes, { workspace = "special:scratchpad silent" })
    hl.exec_cmd(music, { workspace = "special:scratchpad silent" })
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        gaps_workspaces = 0,
        border_size = 0,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle"
    },

    decoration = {
        rounding = 0,
        active_opacity = 1,
        inactive_opacity = 1,
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696
        }
    },

    animations = {
        enabled = true
    },

    dwindle = {
        preserve_split = true
    },

    master = {
        new_status = "master"
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false
    },

    binds = {
        movefocus_cycles_fullscreen = true
    },

    cursor = {
        hide_on_key_press = true
    },

    xwayland = {
        force_zero_scaling = true
    },

    input = {
        kb_layout = "us",
        kb_variant = "mac",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        repeat_rate = 80,
        repeat_delay = 180,
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true
        }
    }
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = false, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = false, speed = 7, bezier = "default" })
hl.animation({ leaf = "border", enabled = false, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = false, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = false, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 6, bezier = "default" })

----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
    name = "rofi",
    match = { title = "^rofi.*" },
    float = true,
    pin = true,
    stay_focused = true
})

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize"
})

---------------------
---- KEYBINDINGS ----
---------------------

local function bind(keys, action, opts)
    hl.bind(mod .. " + " .. keys, action, opts)
end

bind("ESCAPE", hl.dsp.exit())
bind("RETURN", hl.dsp.exec_cmd(terminal))
bind("O", hl.dsp.exec_cmd(lock))
bind("Q", hl.dsp.window.close())
bind("E", hl.dsp.exec_cmd(files))
bind("V", hl.dsp.exec_cmd(clipboard))
bind("D", hl.dsp.exec_cmd(drun))
bind("S", hl.dsp.exec_cmd(ssh))
bind("W", hl.dsp.exec_cmd(window))
bind("C", hl.dsp.exec_cmd(calc))
bind("SHIFT + E", hl.dsp.exec_cmd(emoji))
bind("B", hl.dsp.exec_cmd("pkill -SIGUSR1 " .. bar))

-- The old config bound both togglefloating and togglegroup to SUPER + P
bind("P", function ()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.group.toggle())
end)

hl.bind("Print", hl.dsp.exec_cmd(screenshot))
bind("SHIFT + S", hl.dsp.exec_cmd(screenshot))

bind("R", hl.dsp.submap("resize"))

-- Focus and move with vim keys
local directions = { H = "left", L = "right", K = "up", J = "down" }
for key, direction in pairs(directions) do
    bind(key, hl.dsp.focus({ direction = direction }))
    bind("SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

bind("F", hl.dsp.window.fullscreen())

-- Scratchpad
bind("M", hl.dsp.workspace.toggle_special("scratchpad"))
bind("SHIFT + M", hl.dsp.window.move({ workspace = "special:scratchpad" }))

-- Scroll through existing workspaces
bind("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind("mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Workspaces 1-10 (key 0 is workspace 10)
for i = 1, 10 do
    local key = tostring(i % 10)
    bind(key, hl.dsp.focus({ workspace = i }))
    bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize with the mouse
bind("mouse:272", hl.dsp.window.drag(), { mouse = true })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media and brightness keys (work while locked, repeat while held)
local media = { locked = true, repeating = true }
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), media)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), media)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 5%+"), media)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 5%-"), media)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), media)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"), media)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), media)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), media)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), media)

-- Laptop lid: turn the internal display off when closed, back on when opened
hl.bind("switch:on:Lid Switch", function ()
    hl.monitor({ output = "eDP-1", disabled = true })
end, { locked = true }
)

hl.bind("switch:off:Lid Switch", function ()
    hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })
end, { locked = true }
)

----------------
---- SUBMAP ----
----------------

hl.define_submap("resize", function ()
    local step = 10
    local resize = { repeating = true }
    hl.bind("L", hl.dsp.window.resize({ x = step, y = 0, relative = true }), resize)
    hl.bind("H", hl.dsp.window.resize({ x = -step, y = 0, relative = true }), resize)
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -step, relative = true }), resize)
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = step, relative = true }), resize)
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("catchall", hl.dsp.submap("reset"))
end)
