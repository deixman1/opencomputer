local robot = require "robot"

local L, W = 10, 10

-- /W\
-- ***\
-- *** L
-- ^**/
--
local function forward()
  while not robot.forward() do end
end

robot.select(1)
robot.turnRight()
local turn
for x = 1, L do
  if x%2 == 0 then
    turn = robot.turnRight
  else
    turn = robot.turnLeft
  end
  for z = 1, W do
    if robot.count() == 0 then
      robot.select(robot.select() + 1)
    end
    robot.placeDown()
    if z < W then
      forward()
    elseif x < L then
      turn()
      forward()
      turn()
    end
  end
end
