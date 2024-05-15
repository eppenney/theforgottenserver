local jumpy_button = Action()
local BUTTON_LABEL = "Jump!"

-- Create simple menu when item is used

function jumpy_button.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    createJumpWindow(player);
	return true
end

-- Creates a basic modal window, with one button
function createJumpWindow(player)
    local window = ModalWindow(1000, "Test Menu", "Jumping Button")
    window:addButton(1, BUTTON_LABEL)
    window:sendToPlayer(player)
end

-- Links the item to the explosive arrow item, just for testing 
jumpy_button:id(2546)
jumpy_button:register()
