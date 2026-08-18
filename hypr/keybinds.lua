require("variables")

---------------------
---- KEYBINDINGS ----
---------------------

--- Login Manager ---
hl.bind("SUPER + ALT + Q", hl.dsp.exec_cmd("killall Hyprland"))
hl.bind("SUPER + ALT + SHIFT + Q", hl.dsp.exec_cmd("shutdown now"))


---	Applications	---
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + W", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + V", hl.dsp.exec_cmd(virtManager))
hl.bind("SUPER + A", hl.dsp.exec_cmd(audioManager))
hl.bind("SUPER + P", hl.dsp.exec_cmd(musicPlayer))
hl.bind("SUPER + D", hl.dsp.exec_cmd(discord))
hl.bind("SUPER + L", hl.dsp.exec_cmd("lunarclient"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("obs"))


--- CyberSec  ---
hl.bind("SUPER + C", hl.dsp.exec_cmd("kitty --class cybersec --working-directory ~/Workspace/CyberSec -e fish -C 'source .CyberSec/bin/activate.fish; cd wGet; clear'"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("/home/joe/Workspace/CyberSec/Tools/BurpSuite/BurpSuite"))
hl.bind("SUPER + I", hl.dsp.exec_cmd("wireshark"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("~/Workspace/CyberSec/Tools/BinaryNinja/binaryninja"))
hl.bind("SUPER + Z", hl.dsp.exec_cmd("~/Workspace/CyberSec/Tools/ZAP/zap.sh"))
hl.bind("SUPER + U", hl.dsp.exec_cmd("audacity"))


--- Github  ---
hl.bind("SUPER + G", hl.dsp.exec_cmd("kitty --class github --working-directory ~/Workspace/Contributions/ -e fish -C 'clear; echo 'Repos:'; ls'"))

---   Window Manager	---
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
  { description = "Window: Fullscreen" })

--# Focusing
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Window: Move" })
hl.bind("SUPER + mouse:274", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Window: Resize" })

--#/# binde = SUPER, ;/',, -- Adjust split ratio
hl.bind("SUPER + Semicolon", hl.dsp.layout("splitratio -0.1"), { repeating = true })
hl.bind("SUPER + Apostrophe", hl.dsp.layout("splitratio +0.1"), { repeating = true })


-- Volume Control
local vol_script = "~/.config/hypr/scripts/volume.sh"
local mediaNextCommand =
"playerctl next || playerctl position `bc <<< \"100 * $(playerctl metadata mpris:length) / 1000000 / 100\"`"
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(vol_script .. " up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(vol_script .. " down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(vol_script .. " mute"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(mediaNextCommand), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })

-- Brightness Control
local bright_script = "~/.config/hypr/scripts/brightness.sh"
hl.bind("SUPER + XF86AudioRaiseVolume", hl.dsp.exec_cmd(bright_script .. " up"))
hl.bind("SUPER + XF86AudioLowerVolume", hl.dsp.exec_cmd(bright_script .. " down"))


---   Focus/Move Windows   ---
--#/# bind = SUPER + ←/↑/→/↓,, -- Focus in direction
for i = 1, 4 do
  local arrowkey = { "Left", "Right", "Up", "Down" }
  local focusdir = { "l", "r", "u", "d" }
  hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }),
    { description = "Window: Focus " .. arrowkey[i] })
end

--#/# bind = SUPER + h/k/l/j,, -- Focus in direction
for i = 1, 4 do
  local arrowkey = { "h", "l", "k", "j" }
  local focusdir = { "l", "r", "u", "d" }
  hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }),
    { description = "Window: Focus " .. arrowkey[i] })
end

--#/# bind = SUPER + SHIFT, ←/↑/→/↓,, -- Move in direction
for i = 1, 4 do
  local arrowkey = { "Left", "Right", "Up", "Down" }
  local focusdir = { "l", "r", "u", "d" }
  hl.bind("SUPER + SHIFT + " .. arrowkey[i], hl.dsp.window.move({ direction = focusdir[i] }),
    { description = "Window: Move " .. arrowkey[i] })
end

--#/# bind = SUPER + SHIFT, h/k/l/j,, -- Move in direction
for i = 1, 4 do
  local arrowkey = { "h", "l", "k", "j" }
  local focusdir = { "l", "r", "u", "d" }
  hl.bind("SUPER + SHIFT + " .. arrowkey[i], hl.dsp.window.move({ direction = focusdir[i] }),
    { description = "Window: Move " .. arrowkey[i] })
end

for i = 1, 2 do
  local arrowkey = { "BracketLeft", "BracketRight" }
  local focusdir = { "l", "r" }
  hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }))
end

--# Zoom
local function zoomfunction(value)
  local zoomvalue = hl.get_config("cursor:zoom_factor")
  if (zoomvalue + value) > 3.0 then
    hl.config({ cursor = { zoom_factor = 3.0 } })
  elseif (zoomvalue + value) < 1.0 then
    hl.config({ cursor = { zoom_factor = 1.0 } })
  else
    hl.config({ cursor = { zoom_factor = zoomvalue + value } })
  end
end
hl.bind("SUPER + Minus", function() zoomfunction(-0.3) end, { repeating = true, description = "Screen: Zoom out" })
hl.bind("SUPER + Equal", function() zoomfunction(0.3) end, { repeating = true, description = "Screen: Zoom in" })


---	Workspaces	---
local function isSpecialActive()
  for _, m in pairs(hl.get_monitors()) do
    if m.focused then
      return m.active_special_workspace ~= nil
    end
  end
  return false
end

local function focusWorkspace(target)
  return function()
    if isSpecialActive() then
      hl.dispatch(hl.dsp.workspace.toggle_special("special"))
    end
    hl.dispatch(hl.dsp.focus({ workspace = target }))
  end
end

for i = 1, 10 do
  local key = i % 10
  hl.bind("SUPER + " .. key, focusWorkspace(i))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

for i = 1, 2 do
    local keys = { "Left", "Right" }
    local prefix = { "r-", "r+" }
    local descdir = { "left", "right" }
    hl.bind("CTRL + SUPER + " .. keys[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }), {description = "Workspace: Focus " .. descdir[i]})
end

hl.bind("SUPER + mouse_down", focusWorkspace("+1"))
hl.bind("SUPER + mouse_up", focusWorkspace("-1"))

hl.bind("SUPER + ALT + S",
  hl.dsp.window.move({ workspace = "special:special", follow = false }), { description = "Window: Send to scratchpad" })

hl.bind("SUPER + S", function()
  hl.dispatch(hl.dsp.workspace.toggle_special("special"))
end)

hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"))

hl.bind("SUPER + H", hl.dsp.window.float({ action = "toggle" }))
