-- ! Follow the format defined by the Noctalia [keybind-cheatsheet](https://noctalia.dev/plugins/keybind-cheatsheet) plugin

local mainMod = "SUPER"
local ipc = "qs -c noctalia-shell ipc call"
local home = os.getenv("HOME")

-- 1. APPLICATIONS
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(ipc .. " plugin:keybind-cheatsheet toggle"))                        --"Keybinding cheatsheet"
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(ipc .. " launcher toggle"))                                         --"Application launcher"
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/terminal.sh"))      --"Terminal"
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/file-manager.sh"))       --"File manager"
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/browser.sh"))            --"Browser"
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/music.sh"))      --"Music player"
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/editor.sh"))             --"Text editor"
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/mail.sh"))       --"Email"
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/calculator.sh")) --"Calculator"
hl.bind("XF86Calculator", hl.dsp.exec_cmd(home .. "/.config/singularity/default-apps/calculator.sh"))          --"Calculator"
hl.bind("XF86Calendar", hl.dsp.exec_cmd(ipc .. " calendar toggle"))                                            --"Calendar"

-- 2. SYSTEM ACTIONS
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(ipc .. " sessionMenu toggle"))                                    --"Session menu"
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(ipc .. " lockScreen lock"))                                               --"Lock"
-- hl.bind("XF86Lock", hl.dsp.exec_cmd(ipc .. " lockScreen lock"))                                                      --"Lock"
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness increase"), { locked = true, repeated = true })   --"Brightness up"
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"), { locked = true, repeated = true }) --"Brightness down"

-- 3. UTILITY
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. " launcher clipboard"))                              --"Clipboard history"
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(ipc .. " launcher emoji"))                          --"Emoji selector"
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(ipc .. " plugin:screenshot takeScreenshot region"))         --"Screenshot region selector"
hl.bind("XF86SelectiveScreenshot", hl.dsp.exec_cmd(ipc .. " plugin:screenshot takeScreenshot region")) --"Screenshot region selector"
hl.bind("Print", hl.dsp.exec_cmd(ipc .. " plugin:screenshot takeScreenshot output"))                   --"Screenshot of selected monitor"

-- 4. MULTIMEDIA
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"), { locked = true })                       --"Mute audio output"
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"), { locked = true, repeated = true }) --"Increase volume"
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"), { locked = true, repeated = true }) --"Decrease volume"
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc .. " media playPause"), { locked = true })                         --"Play/pause toggle"
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc .. " media pause"), { locked = true })                            --"Pause track"
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc .. " media next"), { locked = true })                              --"Next track"
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc .. " media previous"), { locked = true })                          --"Previous track"
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. " volume muteInput"), { locked = true })                     --"Mute microphone"

-- 5. WORKSPACE ACTIONS
hl.bind(mainMod .. " + right", hl.dsp.focus({ workspace = "+1" }))   --"Move to next workspace"
hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "-1" }))    --"Move to previous workspace"
hl.bind(mainMod .. " + down", hl.dsp.focus({ workspace = "empty" })) --"Move to first empty workspace"
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))          --"Go to workspace 1"
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))          --"Go to workspace 2"
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))          --"Go to workspace 3"
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))          --"Go to workspace 4"
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))          --"Go to workspace 5"
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))          --"Go to workspace 6"
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))          --"Go to workspace 7"
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))          --"Go to workspace 8"
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))          --"Go to workspace 9"
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))         --"Go to workspace 10"

-- 6. WINDOW ACTIONS
hl.bind(mainMod .. " + Q", hl.dsp.window.close())                                                         --"Quit window"
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())                                                  --"Kill window"
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { repeated = true })                                     --"Cycle windows on workspace"
hl.bind("ALT + Tab", hl.dsp.window.alter_zorder({ mode = "top" }), { repeated = true })
hl.bind(mainMod .. " + up", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))          --"Toggle maximize window"
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) --"Fullscreen"
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))                                    --"Toggle floating/tiling mode"
hl.bind(mainMod .. " + S", hl.dsp.layout("swapsplit"))                                                    --"Swap windows"
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })                                --"Drag window"
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })                              --"Resize window"
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "+1", follow = true }))           --"Move window to next workspace"
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "-1", follow = true }))            --"Move window to previous workspace"
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ workspace = "empty", follow = true }))         --"Move window to first empty workspace"
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = true }))                  --"Move window to workspace 1"
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = true }))                  --"Move window to workspace 2"
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = true }))                  --"Move window to workspace 3"
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = true }))                  --"Move window to workspace 4"
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = true }))                  --"Move window to workspace 5"
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = true }))                  --"Move window to workspace 6"
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = true }))                  --"Move window to workspace 7"
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = true }))                  --"Move window to workspace 8"
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = true }))                  --"Move window to workspace 9"
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = true }))                 --"Move window to workspace 10"
