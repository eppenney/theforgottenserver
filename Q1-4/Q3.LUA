--[[
    Q3 - Fix or improve the name and the implementation of the below method
]]

-- Indentation added 

function removePlayerFromParty(playerId, membername)
    local player = Player(playerId)
    local party = player:getParty()

    -- Handle no party case
    if not party then
        printf("Player has no party");
        return
    end 

    for k,v in pairs(party:getMembers()) do
        if v == Player(membername) then
            party:removeMember(Player(membername))
        end
    end
end
