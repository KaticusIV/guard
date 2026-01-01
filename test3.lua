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

local offset = 0

local function distance(p)
  return math.sqrt(p.x*p.x + p.y*p.y + p.z*p.z)
end

while true do
  local targetDetected = false

  for name,_ in pairs(TARGETS) do
    local player = detector.getPlayer(name)

    if player then
      local dist = distance(player)

      if dist <= MAX_RANGE then
        targetDetected = true
        print("Target:", name, "Dist:", math.floor(dist))

        turtle.attack()
        if turtle.forward() then
          offset = offset + 1
        end
        break
      end
    end
  end

  if not targetDetected and offset > 0 then
    turtle.back()
    offset = offset - 1
  end

  sleep(0.4)
end

