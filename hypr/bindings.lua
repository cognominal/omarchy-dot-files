-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

o.bind("SUPER + H", "Hotkeys", { webapp = "https://omarchy.org/manual/hotkeys/", focus = true })

-- Focus the Chromium omnibox even when the window is fullscreen. A plain
-- CTRL+L keypress can be swallowed by a fullscreen window, so inject it at
-- the compositor level instead. Down/up split works around Hyprland
-- send_shortcut sometimes leaving synthetic key state stuck/repeating:
-- https://github.com/hyprwm/Hyprland/discussions/14099
local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

o.bind("SUPER + ALT + L", "Chromium omnibox", send_shortcut_once("CTRL", "L"))

-- Omarchy sets focus_on_activate = false for Telegram (see
-- default/hypr/apps/telegram.lua) so new messages don't steal focus. That
-- also blocks Telegram's own "raise my window" request when relaunched from
-- the menu while already running. Use launch-or-focus instead: it finds the
-- existing window and dispatches focuswindow directly, bypassing that block.
o.bind("SUPER + SHIFT + T", "Telegram", { focus = "org.telegram.desktop", launch = "Telegram" })

o.bind("SUPER + A", "Agent usage", "omarchy-shell omarchy.agents toggle")

o.bind("SUPER + D", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

o.bind("SUPER + SHIFT + K", "On-Screen Keyboard", "omarchy-shell shell toggle io.github.abdxdev.onscreen-keyboard")

-- Toggle, then flash the OSD with the resulting state
o.bind("SUPER + R", "Key visualizer",
  [[sh -c 'omarchy-shell key-visualizer toggle >/dev/null; if [ "$(omarchy-shell key-visualizer paused)" = true ]; then m="Key visualizer off"; else m="Key visualizer on"; fi; omarchy-osd -i keyboard -m "$m"']])

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
