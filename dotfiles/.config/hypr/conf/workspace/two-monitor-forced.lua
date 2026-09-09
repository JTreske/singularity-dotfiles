local function setup_workspace_rules()
  local monitors = hl.get_monitors()

  if #monitors < 2 then
    return
  end

  local monitor1 = monitors[1]
  local monitor2 = monitors[2]

  for i = 1, 5 do
    hl.workspace_rule({
      workspace = tostring(i),
      monitor = monitor1.name,
      default = (i == 1)
    })
  end

  for i = 6, 10 do
    hl.workspace_rule({
      workspace = tostring(i),
      monitor = monitor2.name,
      default = (i == 6)
    })
  end
end

setup_workspace_rules()

hl.on("monitor.added", setup_workspace_rules)
hl.on("monitor.removed", setup_workspace_rules)
