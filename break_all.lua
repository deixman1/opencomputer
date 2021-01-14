local component = require('component')
local robot = require("robot")
local computer = require("computer")
function add_component(name) -- получение прокси компонента
    name = component.list(name)() -- получить адрес по имени
    if name then -- если есть адрес
        return component.proxy(name) -- вернуть прокси
    end
end
local chest = add_component('inventory_controller')

local inventory = robot.inventorySize()
local height = 70-1
local inner_begin_pos = 2
local width = (16+16+16-inner_begin_pos)-1
local length = (16+16+16-inner_begin_pos)-1
local border = 5-1
local way = height-border
local shit = way % 2
local pos = {x=0, y=0, z=0}
local pos_backup = {x=0, y=0, z=0}
local dir = 0
local dir_backup = 0
local side_home = 2
local side_chest = 1
local position_at_home = false
local need_swing = true

function recursion(h, w, l, circle) -- переход к начальной точке и сброс лута
    os.sleep()
    if circle > w or circle > l then
        return 0
    end
    robot_check()
    for z = circle, l - 1 do
        go(h, circle, z)
    end
    robot_check()
    for x = circle, w - 1 do
        go(h, x, l)
    end
    robot_check()
    for z = l, circle + 1, -1 do
        go(h, w, z)
    end
    robot_check()
    for x = w, circle + 1, -1 do
        go(h, x, circle)
    end
    robot_check()
    if recursion(h, w - 3, l - 3, circle + 3) == 0 then
        return 0
    end

    return circle
end

function forward()
    while not robot.forward() do
        os.sleep()
        robot.swing()
    end
    
    if dir == 0 then pos.x = pos.x+1
    elseif dir == 2 then pos.x = pos.x-1
    elseif dir == 1 then pos.z = pos.z-1
    else pos.z = pos.z+1
    end
end
function up()
    while not robot.up() do
        os.sleep()
        robot.swingUp()
    end
    pos.y = pos.y+1
end
function down()
    while not robot.down() do
        os.sleep()
        robot.swingDown()
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
        os.sleep()
        turn((side-dir)%4==1)
    end
end

function go(y, x, z) -- переход по указанным координатам
    while pos.y ~= y do
        os.sleep()
        if pos.y < y then
            up()
            if need_swing then
            	robot.swing()
            end
        elseif pos.y > y then
            down()
            if need_swing then
            	robot.swing()
            end
        end
    end
    if pos.x < x then
        smart_turn(0)
    elseif pos.x > x then
        smart_turn(2)
    end
    while pos.x ~= x do
        os.sleep()
        forward()
        if need_swing then
            robot.swing()
        end
    end
    if pos.z < z then
        smart_turn(3)
    elseif pos.z > z then
        smart_turn(1)
    end
    while pos.z ~= z do
        os.sleep()
        forward()
        if need_swing then
            robot.swing()
        end
    end
end

function home() -- переход к начальной точке и сброс лута
    pos_backup.x = pos.x
    pos_backup.y = pos.y
    pos_backup.z = pos.z
    dir_backup = dir
    need_swing = false
    print('отправляюсь домой')
    go(0, 0, 0)
    print('прибыл домой')
    position_at_home = true
end

function return_to_work() -- переход к начальной точке и сброс лута
    print('возврат к работе')
    go(pos_backup.y, pos_backup.x, pos_backup.z)
    smart_turn(dir_backup)
    print('прибыл на работу')
    position_at_home = false
    need_swing = true
end

function robot_check()
    local energy = computer.energy()/computer.maxEnergy()
    if energy < 0.1 then
        home()
        smart_turn(side_home)
        while energy < 0.98 do
            print("Низкий заряд. Жду зарядки")
            computer.beep()
            os.sleep(3)
            energy = computer.energy()/computer.maxEnergy()
        end
    end
    if robot.durability() < 0.3 then
        print('пробуем зарядить инструмент')
        home()
        smart_turn(side_home)
        robot.select(1)
        chest.equip()
        local item = chest.getStackInInternalSlot(1)
        local now_charge = 0
        local max_charge = 1
        while not(now_charge == max_charge) do
            robot.drop()
            print('ожидаю зарядки инструмента')
            os.sleep(10)
            robot.suck()
            item = chest.getStackInInternalSlot(1)
            if item then
                now_charge = item.charge
                max_charge = item.maxCharge
            end
        end
        chest.equip()
        print('инструмент заряжен')
    end
    local fill = 0
    for slot = 1, inventory do 
        local item = chest.getStackInInternalSlot(slot)
        if item then
            fill = fill + 1
        end
    end
    if (inventory-fill) < 10 then
        home()
        smart_turn(side_chest)
        for slot = 1, inventory do 
            local item = chest.getStackInInternalSlot(slot)
            if item then
                robot.select(slot)
                robot.drop()
            end
        end
        robot.select(1)
    end
    if position_at_home then
        return_to_work()
    end
end

for y = 0, -way, -3 do
    recursion(y, width, length, 0)
end

if shit ~= 0 then
    recursion(-height, width, length, 0)
end

home()

print('завершено')
