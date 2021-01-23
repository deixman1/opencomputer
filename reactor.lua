local component = require('component')

function add_component(name)
    name = component.list(name)()
    if name then
        return component.proxy(name)
    end
end

local reactor = add_component("reactor")
local redstone = add_component("redstone")
local reactor_inventory_size = reactor.getInventorySize()-4
local limit_dmg = 9500--9500
local limit_heat = 2000
local side_reactor = 3
local side_import = 0
local side_export = 1
local holder = {
    ["reactorCondensatorLap"] = function(item) return item.dmg > limit_dmg end,
    ["reactorCondensator"] = function(item) return item.dmg > limit_dmg end,
    ["reactorMOXQuaddepleted"] = function(item) return true end,
    ["reactorUraniumQuaddepleted"] = function(item) return true end,
    ["reactorUraniumQuad"] = function(item) return false end,
    ["reactorMOXQuad"] = function(item) return false end,
}
--local holder = "reactorCondensator";

function inventory_dmg_check()
    local item
    for i = 1, reactor_inventory_size do
        item = reactor.getStackInSlot(i)
        if not item then
            return false
        else
            if holder[item.name](item) then
                return false
            end
        end
    end
    return true
end

function heat_check()
    if reactor.getHeat() < limit_heat then
        return true
    else
        return false
    end
end

function refilling()
    redstone.setOutput(side_import,15)
    os.sleep(10)
    redstone.setOutput(side_import,0)
    redstone.setOutput(side_export,15)
    os.sleep(10)
    redstone.setOutput(side_export,0)
end

function check()
    return heat_check() and inventory_dmg_check()
end

while true do
    os.sleep()
    if check() then
        redstone.setOutput(side_reactor,15)
    else
        redstone.setOutput(side_reactor,0)
        os.sleep(10)
        refilling()
    end
end
