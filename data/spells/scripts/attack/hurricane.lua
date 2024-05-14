local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)

-- Set custom area to diamond shape. Offset the player position to make pattern fit.
-- Not sure how to have large tornados to either side of center spot and also have player be in center spot.
-- Seems like player is always set to be on a large tornado, even if using 2 in place of 3.
-- Would possibly be better to implement as constant value in spells.lua
combat:setArea(createCombatArea({
	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 3, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 0, 0, 0}
}))

-- Spell callback, as seen in apocalypse spell
function spellCallback(cid, position, count)
	if Creature(cid) then
		if count > 0 then
			-- Do ice tornado effect within area
			doAreaCombat(cid, COMBAT_ICEDAMAGE, position, 0, -100, -100, CONST_ME_ICETORNADO)
		end

		-- 5 iterations seems about right
		if count < 5 then
			count = count + 1
			-- Add another of this event with random delay
			addEvent(spellCallback, math.random(300, 1000), cid, position, count)
		end
	end
end

-- Copied from ice_wave, arbitrary values to make it work as a spell
function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 0.8) + 5
	local max = (level / 5) + (magicLevel * 2) + 12
	return -min, -max
end

-- Activates spellCallback
function onTargetTile(creature, position)
	spellCallback(creature:getId(), position, 0)
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
