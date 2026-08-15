hl.config({
  gestures = {
    workspace_swipe_create_new = false,
  },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Lock screen before suspend
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call lockScreen lock"), { locked = true })
