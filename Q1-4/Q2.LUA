--[[
    Q2 - Fix or improve the implementation of the below method
]]

-- Firs thing, indentation added 

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    
    -- handle invalid memberCount case
    if type(memberCount) ~= "number" or memberCount <= 0 then
        print("Member count invalid.")
        return
    end

    --[[ 
        Guilds table has no field max_members in default tfs schema.
        This *should* select all guild names that have more than membercount 
        entries in guild_memberships. We INNER JOIN with a selection of only 
        id's with counts greater than membercount and return those names. 
    ]]
    local selectGuildQuery = [[
        SELECT g.name
        from guilds g INNER JOIN guild_membership m ON g.id = m.guild_id
        GROUP BY g.id HAVING COUNT(m.player_id)

        SELECT g.name
        FROM guilds g INNER JOIN (
            SELECT guild_id FROM guild_membership
            GROUP BY guild_id HAVING COUNT(*) < %d
        ) AS gm
        ON g.id == gm.guild_id
    ]]


    local resultID = db.storeQuery(string.format(selectGuildQuery, memberCount)) 

    -- handles the case of query error
    if not resultID then
        print("Error executing query")
        return
    end

    -- Need to print out all names with iteration
    repeat 
        -- result methods take ID then string parameter, based on examples I've seen. Shaky on this though. 
        local guildName = result.getString(resultID, "name")
        print(guildName)
    until not result.next(resultID)

    -- Should deallocate up that ID object
    result.free(resultID);
end
