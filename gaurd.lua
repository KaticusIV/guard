-- ===== CONFIG =====
local DETECTOR_SIDE = "left"
local MAX_RANGE = 30
local TARGETS = {
  mario64guy = true,
  Arteth = true
}

-- ===== SETUP =====
local detector = peripheral.wrap(DETECTOR_SIDE)
if not detector then
  error("Player detector not found on " .. DETECTOR_SIDE)
end

print("Guard turtle online")

-- ===== FUNCTIONS =====
local function distance(p)
  return math.sqrt(p.x^2 + p.y^2 + p.z^2)
end

local function faceTarget(p)
  if math.abs(p.x) > math.abs(p.z) then
    if p.x > 0 then
      turtle.turnRight()
    else
      turtle.turnLeft()
    end
  end
end

local function chase(p)
  faceTarget(p)

  if p.z > 1 then
    turtle.forward()
  elseif p.z < -1 then
    turtle.back()
  end

  if p.y > 1 then
    turtle.up()
  elseif p.y < -1 then
    turtle.down()
  end
end

local function attack()
  turtle.attack()
end

-- ===== MAIN LOOP =====
while true do
  local players = detector.getPlayers()

  for name, p in pairs(players) do
    if TARGETS[name] then
      local d = distance(p)

      if d <= MAX_RANGE then
        print("Target acquired:", name)

        while d <= MAX_RANGE do
          chase(p)
          attack()
          sleep(0.2)

          players = detector.getPlayers()
          p = players[name]
          if not p then break end
          d = distance(p)
        end
      end
    end
  end

  sleep(0.5)
end

