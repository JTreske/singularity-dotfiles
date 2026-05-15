hl.layer_rule({
  name = "noctalia",
  match = { namespace = "noctalia-background-.*$" },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})

hl.window_rule({
  name = "",
  match = { class = ".*" },
  workspace = "+0"
})

hl.window_rule({
  name = "ForceCurrentWorkspace",
  match = { class = ".*" },
  workspace = "+0"
})

hl.window_rule({
  name = "gnome-calculator",
  match = { class = "(org.gnome.Calculator)" },
  float = true,
  center = true,
  size = { 700, 400 },
})

hl.window_rule({
  name = "Picture-in-Picture",
  match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
  float = true,
  pin = true,
  center = true,
})
