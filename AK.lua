--[[
This is the script that works with all Logitech mouses. 
It is a simple script that allows you to control the recoil of a weapon in a game. 
The script is activated by pressing "Cap-lock" button, and you can adjust the sensitivity by changing the "sensitivity" variable. 
When the script is activated, you can press the left mouse button to start the movement.
The script will then move the mouse in a specific pattern to control the recoil of the weapon. You can adjust the pattern and the delay as needed.

To use the script, you need to install the Logitech G Hub and create a new script in the profile you desire. 
Then copy and paste the script into the editor and save it.

This script is for educational purposes only. Using macros are against the terms of service of most games and can get you banned. Use at your own risk.
--]]

local isActive = false
local mouseButtonPressed = false
local movePattern = {
    {-4, 7}, {4, 19}, {-3, 29}, {-1, 31}, {13, 31},
    {8, 28}, {13, 21}, {-17, 12}, {-42, -3}, {-21, 2},
    {12, 11}, {-15, 7}, {-26, -8}, {-3, 4}, {40, 1},
    {19, 7}, {14, 10}, {27, 0}, {33, -10}, {-21, -2},
    {7, 3}, {-7, 9}, {-8, 4}, {19, -3}, {5, 6},
    {-20, -1}, {-33, -4}, {-45, -21}, {14, 1}
}
local moveIndex = 1
local modifiers = {1, 2, 3, 4}
local currentModifierIndex = 1
local sensitivity = 0.28

function OnEvent(event, arg)
    if event == "PROFILE_ACTIVATED" then
        EnablePrimaryMouseButtonEvents(true)
    end

    local isActive = IsKeyLockOn("capslock")

    if event == "MOUSE_BUTTON_PRESSED" then
        if arg == 4 then
            currentModifierIndex = (currentModifierIndex % #modifiers) + 1
            OutputLogMessage("Switched to modifier %d\n", modifiers[currentModifierIndex])
        elseif arg == 1 and isActive then
            mouseButtonPressed = true
            OutputLogMessage("Mouse button 1 pressed - starting movement\n")
            StartMouseMovement()
        end
    elseif event == "MOUSE_BUTTON_RELEASED" then
        if arg == 1 then
            mouseButtonPressed = false
            OutputLogMessage("Mouse button 1 released - stopping movement\n")
        end
    end
end

function StartMouseMovement()
    while mouseButtonPressed do
        local move = movePattern[moveIndex]
        local baseModifier = sensitivity / 0.28
        local userModifier = modifiers[currentModifierIndex]
        local totalModifier = baseModifier * userModifier
        
        MoveMouseRelative(move[1] * totalModifier, move[2] * totalModifier)
        Sleep(99)
        moveIndex = (moveIndex % #movePattern) + 1
        if not IsMouseButtonPressed(1) then
            break
        end
    end
end

--[[ This script is developed by Tris The Kitten and you can request feature updates or report bugs on the GitHub page:
I will be updating the script with new features and improvements. Thank you for using the script! --]]