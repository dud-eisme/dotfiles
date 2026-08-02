-----------------------
---- LOOK AND FEEL ----
-----------------------
-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "easeOutQuint" })

-- Windows: switched to bezier instead of spring (springs are the ones misbehaving
-- post-update), speed roughly doubled
hl.animation({ leaf = "windows", enabled = true, speed = 8, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 7, bezier = "easeOutQuint", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "linear", style = "popin 90%" })

-- Fades: fast, minimal
hl.animation({ leaf = "fadeIn", enabled = true, speed = 4, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 6, bezier = "quick" })

-- Layers (popups, notifications, launchers etc.): disabled to cut animation count
hl.animation({ leaf = "layers", enabled = false })
hl.animation({ leaf = "layersIn", enabled = false })
hl.animation({ leaf = "layersOut", enabled = false })
hl.animation({ leaf = "fadeLayersIn", enabled = false })
hl.animation({ leaf = "fadeLayersOut", enabled = false })

-- Workspaces: kept but fast, no fade style (snappier switch)
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "quick" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4, bezier = "quick" })

-- Zoom: disabled — this is the loop-style one that constantly re-renders and
-- costs CPU/GPU/battery even when not visible, per the Hyprland wiki
hl.animation({ leaf = "zoomFactor", enabled = false })
