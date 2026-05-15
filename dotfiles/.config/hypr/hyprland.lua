-- ! IMPORTANT: Do NOT overwrite files provided by Singularity Dotfiles.
-- !            On updates these files will be overwritten.
-- *            Use `~/.config/hypr/conf/custom.lua` for your custom settings.

require("conf.environment")
require("conf.environment-custom")
require("conf.monitor")
require("conf.general")
require("conf.keyboard-layout")
require("conf.input")
require("conf.keybinding")
require("conf.device")
require("conf.layout")
require("conf.autostart")
require("conf.autostart-custom")
require("noctalia.noctalia-colors")
require("conf.animation")
require("conf.decoration")
require("conf.workspace")
require("conf.window-rule")
require("conf.misc")

require("conf.custom")

hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
