local component = require('component')
local robot = require("robot")
function add_component(name) -- получение прокси компонента
    name = component.list(name)() -- получить адрес по имени
    if name then -- если есть адрес
        return component.proxy(name) -- вернуть прокси
    end
end
local chest = add_component('inventory_controller')

function recursion(h, w, l, circle) -- переход к начальной точке и сброс лута
    os.sleep(0)
    if circle > w or circle > l then
        return 0
    end

    for z = circle, l - 1 do
    	go(h, circle, z)
    end

    for x = circle, w - 1 do
        go(h, x, l)
    end
    
    for z = l, circle + 1, -1 do
        go(h, w, z)
    end
    
    for x = w, circle + 1, -1 do
        go(h, x, circle)
    end

    if recursion(h, w - 3, l - 3, circle + 3) == 0 then
        return 0
    end

    return circle
end

function forward()
    while not robot.move(3) do
        os.sleep(0)
        robot.swing(3)
    end
    
    if dir == 0 then pos.x = pos.x+1
    elseif dir == 2 then pos.x = pos.x-1
    elseif dir == 1 then pos.z = pos.z-1
    else pos.z = pos.z+1
    end
end
function up()
    while not robot.up() do
        os.sleep(0)
        robot.swing(1)
    end
    pos.y = pos.y+1
end
function down()
    while not robot.down() do
        os.sleep(0)
        robot.swing(0)
    end
    pos.y = pos.y-1
end
function turnLeft()
    dir = dir-1
    if dir < 0 then
        dir = 3
    end
    robot.turnLeft()
end
function turnRight()
    dir = dir+1
    if dir > 3 then
        dir = 0
    end
    robot.turnRight()
end
function turn(side) -- поворот в сторону
    if side then
        turnRight()
    else
        turnLeft()
    end
end
function smart_turn(side) -- поворот в определенную сторону света
    while dir ~= side do
        os.sleep(0)
        turn((side-dir)%4==1)
    end
end

function go(x, y, z) -- переход по указанным координатам
    while pos.y ~= y do
        os.sleep(0)
        if pos.y < y then
            up()
        elseif pos.y > y then
            down()
        end
    end
    if pos.x < x then
        smart_turn(0)
    elseif pos.x > x then
        smart_turn(2)
    end
    while pos.x ~= x do
        os.sleep(0)
        forward()
    end
    if pos.z < z then
        smart_turn(3)
    elseif pos.z > z then
        smart_turn(1)
    end
    while pos.z ~= z do
        os.sleep(0)
        forward()
    end
end

function home() -- переход к начальной точке и сброс лута
    pos_backup.x = pos.x
    pos_backup.y = pos.y
    pos_backup.z = pos.z
    dir_backup = dir
    print('отправляюсь домой')
    go(0, pos.y+2, 0)
    go(0, 0, 0)
    smart_turn(side_home)
    print('прибыл домой')
    position_at_home = true
end

function return_to_work() -- переход к начальной точке и сброс лута
    print('возврат к работе')
    go(pos_backup.x, pos_backup.y+2, pos_backup.z)
    go(pos_backup.x, pos_backup.y, pos_backup.z)
    smart_turn(dir_backup)
    print('прибыл на работу')
    position_at_home = false
end

function energy_level()
    local energy = computer.energy()/computer.maxEnergy()
    if energy < 0.1 then
        home()
        while energy < 0.98 do
            print("Низкий заряд. Жду зарядки")
            computer.beep()
            os.sleep(3)
            energy = computer.energy()/computer.maxEnergy()
        end
        return_to_work()
    end
    if robot.durability() < 0.3 then
        status('пробуем зарядить инструмент')
        home()
	    robot.select(1)
	    chest.equip()
	    local item = chest.getStackInInternalSlot(1)
	    local now_charge = 0
	    local max_charge = 1
	    while not(now_charge == max_charge) do
	        robot.drop()
	        status('ожидаю зарядки инструмента')
	        os.sleep(10)
	        robot.suck()
	        item = chest.getStackInInternalSlot(1)
	        if item then
	            now_charge = item.charge
	            max_charge = item.maxCharge
	        end
	    end
	    chest.equip()
        status('инструмент заряжен')
    end
end

height = 70
width = 8
length = 8
border = 5
shit = y % 3
pos = {x=0, y=0, z=0}
pos_backup = {x=0, y=0, z=0}
dir = 0
dir_backup = 0
side_home = 0

for y = height-1, border, -3 do
	recursion(y, (width - 1), (length - 1), 0)
end

if (height - shit) ~= height then
	recursion(-border, (width - 1), (length - 1), 0)
end

home()

print('завершено')
