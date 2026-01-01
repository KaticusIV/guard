local TARGETS = {
  "mario64guy",
  "Arteth",
  "KaticusII"
}

local detector = peripheral.wrap("left")
local COOLDOWN = 0.25

print("Guard turtle armed")

while true do
  for _, name in ipairs(TARGETS) do
    local p = detector.getPlayer(name)

    if p then
      -- If player is roughly in front (z close to 1)
      if p.z and p.z > 0 and p.z < 1.5 then
        print("Striking:", name)
        turtle.attack()
        sleep(COOLDOWN)
      end
    end
  end

  sleep(0.1)
end

