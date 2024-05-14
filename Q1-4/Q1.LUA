--[[
    Q1 - Fix or improve the implementation of the below methods
]]

-- First change, some indentation

-- Third, some constants for values for readability and good conventions
local STORAGE_ID = 1000
local DELAY_MS = 1000

local function releaseStorage(player)
    if player then -- Second, double check player validity 
        player:setStorageValue(STORAGE_ID, -1)
    else 
        print("Player invalid") -- I would change to handle error as per system default
    end 
end

function onLogout(player)
    -- Check player validity
    if player then
        if player:getStorageValue(STORAGE_ID) == 1 then
            addEvent(releaseStorage, DELAY_MS, player)
        end
    else 
        print("Player invalid") -- I would change to handle error as per system default
    end
    return true
end
