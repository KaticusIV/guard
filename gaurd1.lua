-- =====================
-- CONFIG
-- =====================
local TARGETS = {
  mario64guy = true,
  Arteth = true
}

local MAX_RANGE = 30
local detector = peripheral.wrap("left")

print("Guard turtle online (NO GPS mode)")

-- Track distance from home
local offset = 0

while true do
  local targetDetected = false

  for name,_ in pairs(TARGETS) do
    local player = detector.getPlayer(name)

    if player and player.distance <= MAX_RANGE then
      targetDetected = true
      print("Target:", name, "Distance:", math.floor(player.distance))

      -- Attack and advance
      turtle.attack()
      if turtle.forward() then
        offset = offset + 1
      end
      break
    end
  end

  -- Return home if no targets
  if not targetDetected and offset > 0 then
    turtle.back()
    offset = offset - 1
  end

  sleep(0.4)
end
