-- ! Follow the format defined by the Noctalia [keybind-cheatsheet](https://noctalia.dev/plugins/keybind-cheatsheet) plugin

local mainMod = "SUPER"
local ipc = "noctalia msg"
local home = os.getenv("HOME")

-- 1. APPLICATIONS
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(ipc .. " panel-toggle kenn/keybind-cheatsheet:cheatsheet"),
  { description = "Keybinding cheatsheet" })
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(ipc .. " panel-toggle launcher"), { description = "Application launcher" })
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/terminal.sh"),
  { description = "Terminal" })
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/file-manager.sh"),
  { description = "File manager" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/browser.sh"),
  { description = "Browser" })
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/music.sh"),
  { description = "Music player" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/editor.sh"),
  { description = "Text editor" })
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/mail.sh"),
  { description = "Email" })
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/calculator.sh"),
  { description = "Calculator" })
hl.bind("XF86Calculator", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/calculator.sh"),
  { description = "Calculator" })
hl.bind("XF86Calendar", hl.dsp.exec_cmd(ipc .. " panel-toggle control-center calendar"), { description = "Calendar" })

-- 2. SYSTEM ACTIONS
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(ipc .. " panel-toggle session"), { description = "Session menu" })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(ipc .. " session lock"), { description = "Lock" })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness-up"),
  { locked = true, repeated = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness-down"),
  { locked = true, repeated = true, description = "Brightness down" })

-- 3. UTILITY
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. " panel-toggle clipboard"), { description = "Clipboard history" })
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(ipc .. " panel-toggle launcher /emo"),
  { description = "Emoji selector" })
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(ipc .. " screenshot-region"),
  { description = "Screenshot region selector" })
hl.bind("XF86SelectiveScreenshot", hl.dsp.exec_cmd(ipc .. " screenshot-region"),
  { description = "Screenshot region selector" })
hl.bind("Print", hl.dsp.exec_cmd(ipc .. " screenshot-fullscreen"),
  { description = "Screenshot of focused monitor" })

-- 4. MULTIMEDIA
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume-mute"),
  { locked = true, description = "Mute audio output" })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume-up"),
  { locked = true, repeated = true, description = "Increase volume" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume-down"),
  { locked = true, repeated = true, description = "Decrease volume" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc .. " media toggle"), { locked = true, description = "Play/pause toggle" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc .. " media pause"), { locked = true, description = "Pause track" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc .. " media next"), { locked = true, description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc .. " media previous"), { locked = true, description = "Previous track" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. " mic-mute"),
  { locked = true, description = "Mute microphone" })

-- 5. WORKSPACE ACTIONS
hl.bind(mainMod .. " + right", hl.dsp.focus({ workspace = "+1" }), { description = "Move to next workspace" })
hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "-1" }), { description = "Move to previous workspace" })
hl.bind(mainMod .. " + down", hl.dsp.focus({ workspace = "empty" }), { description = "Move to first empty workspace" })
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }), { description = "Go to workspace 1" })
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }), { description = "Go to workspace 2" })
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }), { description = "Go to workspace 3" })
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }), { description = "Go to workspace 4" })
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }), { description = "Go to workspace 5" })
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }), { description = "Go to workspace 6" })
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }), { description = "Go to workspace 7" })
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }), { description = "Go to workspace 8" })
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }), { description = "Go to workspace 9" })
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }), { description = "Go to workspace 10" })

-- 6. WINDOW ACTIONS
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Quit window" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill(), { description = "Kill window" })
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { repeated = true, description = "Cycle windows on workspace" })
hl.bind("ALT + Tab", hl.dsp.window.alter_zorder({ mode = "top" }), { repeated = true })
hl.bind(mainMod .. " + up", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
  { description = "Toggle maximize window" })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
  { description = "Fullscreen" })
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating/tiling mode" })
hl.bind(mainMod .. " + S", hl.dsp.layout("swapsplit"), { description = "Swap windows" })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "+1", follow = true }),
  { description = "Move window to next workspace" })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "-1", follow = true }),
  { description = "Move window to previous workspace" })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ workspace = "empty", follow = true }),
  { description = "Move window to first empty workspace" })
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = true }),
  { description = "Move window to workspace 1" })
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = true }),
  { description = "Move window to workspace 2" })
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = true }),
  { description = "Move window to workspace 3" })
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = true }),
  { description = "Move window to workspace 4" })
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = true }),
  { description = "Move window to workspace 5" })
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = true }),
  { description = "Move window to workspace 6" })
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = true }),
  { description = "Move window to workspace 7" })
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = true }),
  { description = "Move window to workspace 8" })
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = true }),
  { description = "Move window to workspace 9" })
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = true }),
  { description = "Move window to workspace 10" })
