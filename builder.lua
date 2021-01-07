local component = require('component')

function add_component(name) -- получение прокси компонента
    name = component.list(name)() -- получить адрес по имени
    if name then -- если есть адрес
        return component.proxy(name) -- вернуть прокси
    end
end

local robot = add_component("robot")
local fs = require("filesystem")
local shell = require("shell") 
local computer = require("computer")
local args = {...}

if #args ~= 1 then
    print("Usage: build <filename>")
    return
end
 
local filename = shell.resolve(args[1])
 
if not fs.exists(filename) then
    print("File \""..filename.."\" does not exist!")
    --return
end

local length = 0
local height = 0
local width = 0
local blocks = {}
local data = {}
 
block_id = {}
 
block_id[0] = "Воздух 0"
block_id[1] = "Камень 1"
block_id[2] = "Трава 2"
block_id[3] = "Грязь 3"
block_id[4] = "Булыжник 4"
block_id[5] = "Деревянная доска 5"
block_id[6] = "Саженец 6"
block_id[7] = "Коренная порода 7"
block_id[8] = "Вода 8"
block_id[9] = "Блок воды 9"
block_id[10] = "Лава 10"
block_id[11] = "Блок лавы 11"
block_id[12] = "Песок 12"
block_id[13] = "Гравий 13"
block_id[14] = "Золотая руда 14"
block_id[15] = "Железо (руда) 15"
block_id[16] = "Угольная руда 16"
block_id[17] = "Журнал 17"
block_id[18] = "Листья 18"
block_id[19] = "Губка 19"
block_id[20] = "Стекло 20"
block_id[21] = "Лазурит (руда) 21"
block_id[22] = "Лазурит (Блок) 22"
block_id[23] = "Диспенсер 23"
block_id[24] = "Песчаник 24"
block_id[25] = "Блокировать объект плитки заметки 25"
block_id[26] = "Кровать 26"
block_id[27] = "Рельс с питанием 27"
block_id[28] = "Детекторная рейка 28"
block_id[29] = "липкий поршень 29"
block_id[30] = "Паутина 30"
block_id[31] = "Высокая трава 31"
block_id[32] = "Мертвый куст 32"
block_id[33] = "Поршень 33"
block_id[34] = "Удлинитель поршня 34"
block_id[35] = "Шерсть 35"
block_id[36] = "Блок перемещен поршнем 36"
block_id[37] = "Одуванчик 37"
block_id[38] = "Роза 38"
block_id[39] = "Коричневый гриб 39"
block_id[40] = "Красный гриб 40"
block_id[41] = "Золотой слиток 41"
block_id[42] = "Железный блок 42"
block_id[43] = "Двойные плиты 43"
block_id[44] = "Плиты 44"
block_id[45] = "Кирпичный блок 45"
block_id[46] = "TNT 46"
block_id[47] = "Книжная полка 47"
block_id[48] = "Моховой камень 48"
block_id[49] = "Обсидиан 49"
block_id[50] = "Факел 50"
block_id[51] = "Огонь 51"
block_id[52] = "Создатель монстров 52"
block_id[53] = "Деревянная лестница 53"
block_id[54] = "Сундук 54"
block_id[55] = "Редстоун (проволока) 55"
block_id[56] = "Алмаз (руда) 56"
block_id[57] = "Алмазный блок 57"
block_id[58] = "Стол для крафта 58"
block_id[59] = "Семена 59"
block_id[60] = "Приусадебный участок 60"
block_id[61] = "Печь 61"
block_id[62] = "Горящая печь 62"
block_id[63] = "Подписать сообщение 63"
block_id[64] = "Деревянная дверь 64"
block_id[65] = "Лестницы 65"
block_id[66] = "Рельсы 66"
block_id[67] = "Лестница из булыжника 67"
block_id[68] = "Настенная табличка 68"
block_id[69] = "Рычаг 69"
block_id[70] = "Каменная нажимная пластина 70"
block_id[71] = "Железная дверь 71"
block_id[72] = "Деревянные прижимные пластины 72"
block_id[73] = "Редстоуновая руда 73"
block_id[74] = "Светящаяся руда красного камня 74"
block_id[75] = "Красный факел 75"
block_id[76] = "Красный факел 76"
block_id[77] = "Каменная кнопка 77"
block_id[78] = "Снег 78"
block_id[79] = "Лед 79"
block_id[80] = "Снежный блок 80"
block_id[81] = "Кактус 81"
block_id[82] = "Глина (Блок) 82"
block_id[83] = "Сахарный тростник 83"
block_id[84] = "Музыкальный автомат 84"
block_id[85] = "Забор 85"
block_id[86] = "Тыква 86"
block_id[87] = "Netherrack 87"
block_id[88] = "Песок души 88"
block_id[89] = "Светящийся камень 89"
block_id[90] = "Портал 90"
block_id[91] = "Фонарь из Джека 91"
block_id[92] = "Блок торта 92"
block_id[93] = "Повторитель красного камня 93"
block_id[94] = "Повторитель красного камня 94"
block_id[95] = "Запертый сундук 95"
block_id[96] = "Люки 96"
block_id[97] = "Скрытая серебрянная рыбка 97"
block_id[98] = "Каменный кирпич 98"
block_id[99] = "Огромный коричнево-красный гриб 99"
block_id[100] = "Огромный коричнево-красный гриб 100"
block_id[101] = "Железные слитки 101"
block_id[102] = "Стеклянная панель 102"
block_id[103] = "Дыня 103"
block_id[104] = "Тыквенный стебель 104"
block_id[105] = "Стебель дыни 105"
block_id[106] = "Виноградная лоза 106"
block_id[107] = "Ворота забора 107"
block_id[108] = "Кирпичная лестница 108"
block_id[109] = "Лестница из каменного кирпича 109"
block_id[110] = "Мицелий 110"
block_id[111] = "Кувшинок 111"
block_id[112] = "Пустой кирпич 112"
block_id[113] = "Забор из кирпича Пустоты 113"
block_id[114] = "Лестница из кирпича Пустоты 114"
block_id[115] = "Бородавка Пустоты 115"
block_id[116] = "Таблица зачарования 116"
block_id[117] = "Пивоварня 117"
block_id[118] = "Котел 118"
block_id[119] = "Портал Эндер 119"
block_id[120] = "Конечный фрейм портала 120"
block_id[121] = "Камень Эндера 121"
block_id[256] = "Железная лопата 256"
block_id[257] = "Железная кирка 257"
block_id[258] = "Железный топор 258"
block_id[259] = "Кремень и сталь 259"
block_id[260] = "Красное яблоко 260"
block_id[261] = "Лук 261"
block_id[262] = "Стрелка 262"
block_id[263] = "Уголь 263"
 
wool = {}
wool[0] = "Белый"
wool[1] = "Апельсин"
wool[2] = "пурпурный"
wool[3] = "Голубой"
wool[4] = "желтый"
wool[5] = "лайм"
wool[6] = "розовый"
wool[7] = "серый"
wool[8] = "Светло-серый"
wool[9] = "голубой"
wool[10] = "фиолетовый"
wool[11] = "синий"
wool[12] = "коричневый"
wool[13] = "зеленый"
wool[14] = "красный"
wool[15] = "черный"
 
function getBlockName(id, blockData)
    blockData = blockData or nil
    if(block_id[id] == nil) then
        return "UNKNOWN_"..id.."/"..blockData
    else
        if(blockData) then
            if(id == 35) then
                str = wool[blockData] .. " " .. block_id[id]
                return str
            end
        end
        return block_id[id]
    end
end
 
function getBlockId(x,y,z)
    return blocks[y + z*width + x*length*width + 1]
end
 
function getData(x,y,z)
    return data[y + z*width + x*length*width + 1]
end
 
function readbytes(file, n)
    for i=1,n do
        string.byte(file:read(1))
    end
end
 
function readname(file)    
    n1 = string.byte(file:read(1))
    n2 = string.byte(file:read(1))
 
    if(n1 == nil or n2 == nil) then
        return ""
    end
 
    n = n1*256 + n2
 
    str = ""
    for i=1,n do
        c = file:read(1)
        if c == nil then
            return
        end 
        str = str .. c
    end
    --
    --print("Name: "..str)
    --io.read()
    --
    return str
end
 
function parse(a, file, containsName)
    if containsName == nil then containsName = true end
    --print(a)
    if a==0 then
        return
    end
    if containsName then
        name = readname(file)
    end
     
    if a==1 then
        readbytes(file,1)    
    elseif a==2 then
        i1 = string.byte(file:read(1))
        i2 = string.byte(file:read(1))
        i = i1*256 + i2
        if(name=="Height") then
            height = i
        elseif (name=="Length") then
            length = i
        elseif (name=="Width") then
            width = i
        end
    elseif a==3 then
        readbytes(file,4)
    elseif a==4 then
        readbytes(file,8)
    elseif a==5 then
        readbytes(file,4)
    elseif a==6 then
        readbytes(file,8)
    elseif a==7 then
        i1 = string.byte(file:read(1))
        i2 = string.byte(file:read(1))
        i3 = string.byte(file:read(1))
        i4 = string.byte(file:read(1))
        i = i1*256*256*256 + i2*256*256 + i3*256 + i4
        if name == "Blocks" then
            for i=1,i do
                table.insert(blocks, string.byte(file:read(1)))
            end
        elseif name == "Data" then
            for i=1,i do
                table.insert(data, string.byte(file:read(1)))
            end
        else
            readbytes(file,i)
        end
    elseif a==8 then
        i1 = string.byte(file:read(1))
        i2 = string.byte(file:read(1))
        i = i1*256 + i2
        readbytes(file,i)
    elseif a==9 then
        t = string.byte(file:read(1))
        i1 = string.byte(file:read(1))
        i2 = string.byte(file:read(1))
        i3 = string.byte(file:read(1))
        i4 = string.byte(file:read(1))
        i = i1*256*256*256 + i2*256*256 + i3*256 + i4
        --print("Num: "..i)
        for j=1,i do
            --print("Step: "..j.." of "..i)
            if t ~= 10 then
                parse(t, file, false)
            else
                break
                --parse(string.byte(file:read(1)), file)
            end
        end
    end
end

pos = {x=0, y=0, z=0}
pos_backup = {x=0, y=0, z=0}
dir = 0
dir_backup = 0

function forward()
    while not robot.move(3) do
        robot.swing(3)
    end
    
    if dir == 0 then pos.x = pos.x+1
    elseif dir == 2 then pos.x = pos.x-1
    elseif dir == 1 then pos.z = pos.z-1
    else pos.z = pos.z+1
    end
end
function up()
    while not robot.move(1) do
        robot.swing(1)
    end
    pos.y = pos.y+1
end
function down()
    while not robot.move(0) do
        robot.swing(0)
    end
    pos.y = pos.y-1
end
function turnLeft()
    dir = dir-1
    if dir < 0 then
        dir = 3
    end
    robot.turn(false)
end
function turnRight()
    dir = dir+1
    if dir > 3 then
        dir = 0
    end
    robot.turn(true)
end

function place()
    while not robot.place(0) do
        robot.swing(0)
    end
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
        turn((side-dir)%4==1)
    end
end

function go(x, y, z) -- переход по указанным координатам
    while pos.y ~= y do
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
        forward()
    end
    if pos.z < z then
        smart_turn(3)
    elseif pos.z > z then
        smart_turn(1)
    end
    while pos.z ~= z do
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
    print('прибыл домой')
end

function return_to_work() -- переход к начальной точке и сброс лута
    print('возврат к работе')
    go(pos_backup.x, pos_backup.y+2, pos_backup.z)
    go(pos_backup.x, pos_backup.y, pos_backup.z)
    smart_turn(dir_backup)
    print('прибыл на работу')
end

file = io.open(filename, "rb")
 
a = 0
while (a ~= nil) do
    a = file:read(1)
    if a == nil then break end
    a = string.byte(a)
    parse(a, file)
end
 
print("Length: " .. length)
print("Width: " .. width)
print("Height: " .. height)
 
uniqueblocks={}
for i,v in ipairs(blocks) do
    if v ~= 0 then
        found = false
        for j,w in ipairs(uniqueblocks) do
            -- for now, data is only accounted for when the block is whool
                if (w.blockID==v and (w.data==data[i] or w.blockID ~= 35)) then
                    found = true
                    w.amount = w.amount + 1
                break
            end
        end
        if found==false then
            uniqueblocks[#uniqueblocks+1] = {}
            uniqueblocks[#uniqueblocks].blockID = v
            uniqueblocks[#uniqueblocks].data = data[i]
            uniqueblocks[#uniqueblocks].amount = 1
        end
    end
end
 
print("Number of block types: " .. #uniqueblocks)
for i,v in ipairs(uniqueblocks) do
    if (i%9)==0 then
        io.read()
    end
    print(" " .. getBlockName(v.blockID, v.data) .. ": " .. v.amount .. ". ")
end
 
io.read()
 
print("Give the numbers of all slots containing the specified block type:")
 
slots={}
for i,block in ipairs(uniqueblocks) do
    blockData = block.data
    io.write(" -in which slots is " .. getBlockName(block.blockID, blockData) .. "?")
    if not slots[block.blockID] then
        slots[block.blockID] = {}
    end
    slots[block.blockID][blockData] = {}
    io.write("     ")
    str = io.read()
    io.write("\n")
    for i = 1, #str do
        local c = str:sub(i,i)
        n = tonumber(c)
        if(n) then
            if(n>0 and n<10) then
                table.insert(slots[block.blockID][blockData], n)
            end
        end
    end
end
 
print("Press key to start building...")
io.read()
 
up()
forward()
n = 1
robot.select(n)
 
for y=1,height do
    for x=1,width do
        for z=1,length do
            local file = io.open("logs.txt", "a")
            file:write("\nX: "..pos.x..", Y: "..pos.y..", Z: "..pos.z)
            file:close()
            blockID = getBlockId(y-1,x-1,z-1)
            blockData = getData(y-1,x-1,z-1)
            energy_level()
            if blockID == 0 then 
                --robot.swing(0)
            else
                slot_lst = slots[blockID][blockData]
                if(slot_lst ~= nil) then
                    if(#slot_lst > 0) then
                        local found=false
                        for i,v in ipairs(slot_lst) do
                            if(robot.count(v) > 0) then
                                found=true
                                robot.select(v)
                                break
                            end
                        end
                        if not found then
                            io.write("Not enough " .. getBlockName(blockID, blockData).." (")
                            for i,v in ipairs(slot_lst) do
                                io.write(v.." ")
                            end
                            io.write("\b). Please refill...\n")
                            io.read()
                        end
                        go((x - 1) + 1, (y - 1) + 1, (z - 1))
                        place()
                    end
                end
            end
        end
    end
    
end

home()
