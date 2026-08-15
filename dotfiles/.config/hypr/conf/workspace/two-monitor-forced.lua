local monitors = hl.get_monitors()

local monitor1 = monitors[1]
-- Fallback to monitor1 if monitor2 is not available
local monitor2 = monitors[2] or monitors[1]

for i = 1, 5 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor = monitor1.name,
  })
end

for i = 6, 10 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor = monitor2.name,
  })
end
