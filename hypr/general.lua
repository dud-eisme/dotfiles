------------------
---- MONITORS ----
------------------

hl.monitor({
  output   = "eDP-1",
  mode     = "2560x1600@60",
  position = "0x0",
  scale    = 1,
})

hl.monitor({
  output   = "VNC-1",
  mode     = "1920x1080@60",
  position = "2560x0",
  scale    = 1,
  transform= 1,
})


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    gaps_in           = 5,
    gaps_out          = 5,

    border_size       = 4,

    col               = {
      active_border   = "rgba(9067C6CC)",
      inactive_border = "rgba(000000FF)",
    },

    no_focus_fallback = true,
    resize_on_border  = false,
    allow_tearing     = false,
    layout            = "dwindle",
  },

  decoration = {
    rounding         = 10,
    rounding_power   = 2,

    active_opacity   = 0.99,
    inactive_opacity = 0.99,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0x331a1a1a,
    },

    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
})


hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})



----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
  },
})


-----------------
--- Hyprglass ---
-----------------

if hl.plugin.hyprglass then
    local hg = hl.plugin.hyprglass

    hg.config({
        default_theme = "dark",
        default_preset = "clear",
        tint_color = 0x8899aa22,

        brightness = 0.9,
        dark = { brightness = 0.82 },
        light = { adaptive_boost = 0.5 },

        layers = { enabled = 1 },
    })

    -- Layer surfaces: each call whitelists the namespace and configures it
    hg.layer("waybar", { preset = "subtle", mask_threshold = 0.05 })
    hg.layer("swaync")
    hg.layer("quickshell:bezel", { preset = "ui", mask_threshold = 0.3 })
    hg.layer("debug-panel", { exclude = true })

    -- Presets
    hg.preset("clear", {
        glass_opacity = 0.8,
        blur_strength = 1.5,
        dark = { brightness = 0.7 },
        light = { brightness = 1.2 },
    })

    hg.preset("contrasted", {
        inherits = "high_contrast",
        contrast = 1.2,
        adaptive_dim = 1.5,
        dark = { tint_color = 0x02142aa9 },
    })
end
