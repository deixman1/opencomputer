local robot = require('robot')
local height = 1
local width = 5 -- plus 1
local turns = 2
local length = 5 -- plus 1
local circles = math.ceil(width/2)-1
local inventory_size = robot.inventorySize()

check_item = function()
	local item = false
	for slot=1,inventory_size do
		if robot.count(slot) > 0 then -- если слот пуст
      		robot.select(slot) -- выбрать слот
      		do return end
      		break
    	end
	end
	item = true
	while item do
		for slot=1,inventory_size do
			if robot.count(slot) > 0 then -- если слот пуст
	      		robot.select(slot) -- выбрать слот
	      		item = false
	      		break
	    	end
		end
		print('no items')
	    os.sleep(30)
	end
end

for i=1,height do
	robot.up()
	for i=1,turns do
		for i=1,length do
			check_item()
			robot.placeDown()
			robot.forward()
		end
		robot.turnRight()
		for i=1,width do
			check_item()
			robot.placeDown()
			robot.forward()
		end
		robot.turnRight()
	end
end

robot.forward()
robot.turnRight()
robot.forward()

local turn = true
for i=1,circles do
	length = length - 2
	width = width - 2
	for i=1,turns do
		for i=1,length do
			check_item()
			robot.placeDown()
			robot.forward()
		end
		if turn then
			robot.turnLeft()
		else
			robot.turnRight()
		end
		for i=1,width do
			check_item()
			robot.placeDown()
			robot.forward()
		end
		if turn then
			robot.turnLeft()
		else
			robot.turnRight()
		end
	end
	robot.forward()
	if turn then
		robot.turnLeft()
		turn = false
	else
		robot.turnRight()
		turn = true
	end
	robot.forward()
end
