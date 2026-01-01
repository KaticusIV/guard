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

local function getDistance(p)
  -- Variant A
  if p.x and p.y and p.z then
    return math.sqrt(p.x*p.x + p.y*p.y + p.z*p.z)
  end

  -- Variant B
  if p.dx and p.dy and p.dz then
    return math.sqrt(p.dx*p.dx + p.dy*p.dy + p.dz*p.dz)
  end

  -- Variant C
  if p.position and p.position.x then
    local x = p.position.x
    local y = p.position.y or 0
    local z = p.position.z
    return math.sqrt(x*x + y*y + z*z)
  end

  return nil
end

while true do
  local targetDetected = false

  for name,_ in pairs(TARGETS) do
    local player = detector.getPlayer(name)

    if player then
      local dist = getDistanc

