-- CONFIG
local TARGETS = {
  mario64guy = true,
  Arteth = true
}

local MAX_RANGE = 30
local detector = peripheral.wrap("left")

print("Guard turtle online")

-- Save home position
local homeX, homeY, homeZ = gps.locate(5)

if not homeX then
  error("GPS not available")
end

local function distance(x1,y1,z1,x2,y2,z2)
  return math.sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2)
end

while true do
  for name,_ in pairs(TARGETS) do
    local player = detector.getPlayer(name)

    if player then
      local px, py, pz = player.x, player.y, player.z
      local d = distance(homeX, homeY, homeZ, px, py, pz)

      if d <= MAX_RANGE then
        print("Target detected:", name)

        -- VERY simple chase: walk forward and attack
        turtle.attack()
        turtle.forward()
      end
    end
  end

  -- If no targets, return home
  local cx, cy, cz = gps.locate(5)
  if cx and distance(cx,cy,cz,homeX,homeY,homeZ) > 1 then
    turtle.back()
  end

  sleep(0.5)
end

