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
local chest = add_component('inventory_controller')
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

local inventory = robot.inventorySize()
local length = 0
local height = 0
local width = 0
local blocks = {}
local data = {}
local position_at_home = false
 
block_id = {}
 
block_id[0] = "воздух 0"
block_id[1] = "камень 1"
block_id[2] = "трава 2"
block_id[3] = "грязь 3"
block_id[4] = "булыжник 4"
block_id[5] = "доски 5"
block_id[6] = "саженец 6"
block_id[7] = "коренная порода 7"
block_id[8] = "проточная вода 8"
block_id[9] = "вода 9"
block_id[10] = "текущая лава 10"
block_id[11] = "лава 11"
block_id[12] = "песок 12"
block_id[13] = "гравий 13"
block_id[14] = "золотая руда 14"
block_id[15] = "железная руда 15"
block_id[16] = "угольная руда 16"
block_id[17] = "журнал 17"
block_id[18] = "оставляет 18"
block_id[19] = "губка 19"
block_id[20] = "стакан 20"
block_id[21] = "ляпис-руда 21"
block_id[22] = "ляпис-блок 22"
block_id[23] = "дозатор 23"
block_id[24] = "песчаник 24"
block_id[25] = "блокнот 25"
block_id[26] = "кровать 26"
block_id[27] = "золотой рельс 27"
block_id[28] = "направляющая детектора 28"
block_id[29] = "липкий поршень 29"
block_id[30] = "сеть 30"
block_id[31] = "высокая трава 31"
block_id[32] = "мертвый куст 32"
block_id[33] = "поршень 33"
block_id[34] = "головка поршня 34"
block_id[35] = "шерсть 35"
block_id[36] = "удлинитель поршня 36"
block_id[37] = "желтый цветок 37"
block_id[38] = "красный цветок 38"
block_id[39] = "коричневый гриб 39"
block_id[40] = "красный гриб 40"
block_id[41] = "золотой блок 41"
block_id[42] = "железный блок 42"
block_id[43] = "двойная каменная плита 43"
block_id[44] = "каменная плита 44"
block_id[45] = "кирпичный блок 45"
block_id[46] = "tnt 46"
block_id[47] = "книжная полка 47"
block_id[48] = "мшистый булыжник 48"
block_id[49] = "обсидиан 49"
block_id[50] = "факел 50"
block_id[51] = "огонь 51"
block_id[52] = "создатель мобов 52"
block_id[53] = "дубовая лестница 53"
block_id[54] = "сундук 54"
block_id[55] = "провод из красного камня 55"
block_id[56] = "алмазная руда 56"
block_id[57] = "алмазный блок 57"
block_id[58] = "верстак 58"
block_id[59] = "пшеница 59"
block_id[60] = "сельхозугодья 60"
block_id[61] = "печь 61"
block_id[62] = "зажженная печь 62"
block_id[63] = "постоянный знак 63"
block_id[64] = "деревянная дверь 64"
block_id[65] = "лестница 65"
block_id[66] = "рельс 66"
block_id[67] = "каменная лестница 67"
block_id[68] = "настенная табличка 68"
block_id[69] = "рычаг 69"
block_id[70] = "каменная прижимная пластина 70"
block_id[71] = "железная дверь 71"
block_id[72] = "деревянная прижимная пластина 72"
block_id[73] = "руда красного камня 73"
block_id[74] = "освещенная руда красного камня 74"
block_id[75] = "неосвещенный факел из красного камня 75"
block_id[76] = "факел из красного камня 76"
block_id[77] = "каменная кнопка 77"
block_id[78] = "слой снега 78"
block_id[79] = "лед 79"
block_id[80] = "снег 80"
block_id[81] = "кактус 81"
block_id[82] = "глина 82"
block_id[83] = "трость 83"
block_id[84] = "музыкальный автомат 84"
block_id[85] = "забор 85"
block_id[86] = "тыква 86"
block_id[87] = "netherrack 87"
block_id[88] = "песок души 88"
block_id[89] = "светящийся камень 89"
block_id[90] = "портал 90"
block_id[91] = "зажженная тыква 91"
block_id[92] = "торт 92"
block_id[93] = "ретранслятор 93 без питания"
block_id[94] = "ретранслятор с питанием 94"
block_id[95] = "витраж 95"
block_id[96] = "люк 96"
block_id[97] = "яйцо монстра 97"
block_id[98] = "каменный кирпич 98"
block_id[99] = "коричневый грибной блок 99"
block_id[100] = "красный грибной блок 100"
block_id[101] = "101 железный пруток"
block_id[102] = "стеклянная панель 102"
block_id[103] = "дынный блок 103"
block_id[104] = "стебель тыквы 104"
block_id[105] = "стебель дыни 105"
block_id[106] = "лоза 106"
block_id[107] = "ворота 107"
block_id[108] = "кирпичная лестница 108"
block_id[109] = "лестница из каменного кирпича 109"
block_id[110] = "мицелий 110"
block_id[111] = "водяная лилия 111"
block_id[112] = "адский кирпич 112"
block_id[113] = "забор из нижнего кирпича 113"
block_id[114] = "лестница из нижнего кирпича 114"
block_id[115] = "нижняя бородавка 115"
block_id[116] = "таблица чар 116"
block_id[117] = "пивоваренный стенд 117"
block_id[118] = "котел 118"
block_id[119] = "конечный портал 119"
block_id[120] = "конец 120 фрейма портала"
block_id[121] = "конечный камень 121"
block_id[122] = "яйцо дракона 122"
block_id[123] = "лампа красного камня 123"
block_id[124] = "горит лампа красного камня 124"
block_id[125] = "двойная деревянная плита 125"
block_id[126] = "деревянная плита 126"
block_id[127] = "какао 127"
block_id[128] = "лестница из песчаника 128"
block_id[129] = "изумрудная руда 129"
block_id[130] = "сундук конца 130"
block_id[131] = "крючок растяжки 131"
block_id[132] = "Tripwire 132"
block_id[133] = "изумрудный блок 133"
block_id[134] = "еловая лестница 134"
block_id[135] = "березовая лестница 135"
block_id[136] = "лестница из джунглей 136"
block_id[137] = "командный блок 137"
block_id[138] = "маяк 138"
block_id[139] = "стена из булыжника 139"
block_id[140] = "цветочный горшок 140"
block_id[141] = "морковь 141"
block_id[142] = "картофель 142"
block_id[143] = "деревянная пуговица 143"
block_id[144] = "череп 144"
block_id[145] = "наковальня 145"
block_id[146] = "сундук-ловушка 146"
block_id[147] = "легкая нажимная пластина 147"
block_id[148] = "тяжелая нажимная пластина 148"
block_id[149] = "компаратор 149 без питания"
block_id[150] = "компаратор 150 с питанием"
block_id[151] = "датчик дневного света 151"
block_id[152] = "блок из красного камня 152"
block_id[153] = "кварцевая руда 153"
block_id[154] = "хоппер 154"
block_id[155] = "кварцевый блок 155"
block_id[156] = "кварцевая лестница 156"
block_id[157] = "направляющая активатора 157"
block_id[158] = "капельница 158"
block_id[159] = "закаленная глина 159"
block_id[160] = "витраж 160"
block_id[161] = "оставляет2 161"
block_id[162] = "log2 162"
block_id[163] = "лестница из акации 163"
block_id[164] = "лестница из темного дуба 164"
 
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
            return block_id[id]..":"..blockData
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
side_home = 0

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

function refilling(slot, name)
    smart_turn(side_home)
    robot.suck()
    while robot.count(slot) > 0 do
        computer.beep()
        print('нет предмета в сундуке '..name)
        os.sleep(3)
        robot.suck()
    end
end

function main(y,x,z, blockID, blockData) -- переход к начальной точке и сброс лута
    local file = io.open("logs.txt", "a")
    file:write("\nX: "..pos.x..", Y: "..pos.y..", Z: "..pos.z)
    file:close()
    blockID_cur = getBlockId(y,x,z)
    blockData_cur = getData(y,x,z)
    energy_level()
    if blockID_cur ~= blockID and blockData_cur ~= blockData then 
      --
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
                    io.write("Нет блока " .. getBlockName(blockID,blockData))
                    --[[for i,v in ipairs(slot_lst) do
                        io.write(v.." ")
                    end--]]
                    print('Пытаюсь восполнить')
                    if not position_at_home then
                        home()
                    end
                    refilling(1, getBlockName(blockID,blockData))
                    return_to_work()
                end
                go(x + 1, y + 1, z)
                place()
            end
        end
    end
end

function recursion(y, w, l, circle, blockID, blockData) -- переход к начальной точке и сброс лута
    if circle > w or circle > l then
        return 0
    end

    for z = circle, l - 1 do
        main(y, circle, z, blockID, blockData)
    end

    for x = circle, w - 1 do
        main(y, x, l, blockID, blockData)
    end
    
    for z = l, circle + 1, -1 do
        main(y, w, z, blockID, blockData)
    end
    
    for x = w, circle + 1, -1 do
        main(y, x, circle, blockID, blockData)
    end

    if recursion(y, w - 1, l - 1, circle + 1, blockID, blockData) == 0 then
        return 0
    end

    return circle
end

file = io.open(filename, "rb")
 
a = 0
while (a ~= nil) do
    a = file:read(1)
    if a == nil then break end
    a = string.byte(a)
    parse(a, file)
end
file:close()

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

--[[if #uniqueblocks > inventory then
    print("инвентарь "..inventory)
    print("блоков "..#uniqueblocks)
    print("Количество блоков в схеме больше размера инвентаря робота. Продолжить? [y/n]")
    str = io.read()
    if str == "n" then
        os.exit()
    end
end--]]

io.read()
 
print("Give the numbers of all slots containing the specified block type:")

slots={}
block_list = {}
for i,block in ipairs(uniqueblocks) do
    blockData = block.data
    --io.write(" -расположение в слоте "..slot_count.." предмета: " .. getBlockName(block.blockID,blockData) .. "? [y/n]")
    io.write(" -строить блок: " .. getBlockName(block.blockID,blockData) .. "? [y/n]")
    if not slots[block.blockID] then
        slots[block.blockID] = {}
    end
    slots[block.blockID][blockData] = {}
    str = io.read()
    io.write("\n")
    if str == "y" then
        block_list[#block_list+1] = {block.blockID,blockData}
        table.insert(slots[block.blockID][blockData], 1)
    end
end
 
print("Начать строительство? [y/n]")
str = io.read()
if str == "n" then
    os.exit()
end


turn()
turn()
side_home = dir
turn()
turn()

up()
forward()
n = 1
robot.select(n)

for i,block in ipairs(block_list) do
    print(block[1] .. " " .. block[2])
    for y = 0, (height - 1) do
        recursion(y, (width - 1), (length - 1), 0, block[1], block[2])
    end
    home()
    if robot.count(1) > 0 then
        robot.dropDown()
    end
end

home()

print('работа выполнена')
