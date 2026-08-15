hl.config({
  decoration = {
    rounding = 10,
    rounding_power = 2.0,

    active_opacity = 1.0,
    inactive_opacity = 1.0,
    fullscreen_opacity = 1.0,

    dim_modal = true,
    dim_inactive = true,
    dim_strength = 0.05,
    dim_special = 0.2,

    blur = {
      -- does not change anything with full opacity
      enabled = false,
    },

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
  },
})
