--[[
This is the script that works with all Logitech mice. 
It is a simple script that allows you to control the recoil of a weapon in a game. 
The script is activated by pressing the "Cap-lock" button, and you can adjust the sensitivity by changing the "sensitivity" variable. 
When the script is activated, you can press the left mouse button to start the movement.
The script then moves the mouse in a specific pattern to control the weapon's recoil. You can adjust the pattern and the delay as needed.

To use the script, you need to install the Logitech G Hub and create a new script in the desired profile. 
Then copy and paste the script into the editor and save it.

This script is for educational purposes only. Using macros is against most games' terms of service and can get you banned. Use at your own risk.
--]]

local config = {
    settings = {
        sensitivity = 0.28,
    }
}

local isMouseButtonPressed = false
local movementIndex = 1

local movementPattern = {
    {-4, 7}, {4, 19}, {-3, 29}, {-1, 31}, {13, 31},
    {8, 28}, {13, 21}, {-17, 12}, {-42, -3}, {-21, 2},
    {12, 11}, {-15, 7}, {-26, -8}, {-3, 4}, {40, 1},
    {19, 7}, {14, 10}, {27, 0}, {33, -10}, {-21, -2},
    {7, 3}, {-7, 9}, {-8, 4}, {19, -3}, {5, 6},
    {-20, -1}, {-33, -4}, {-45, -21}, {-14, 1}
}

local movementModifier = 2.52 / config.settings.sensitivity

local movementSmoothness = 2

local function performSmoothMouseMovement(x, y, smoothness)
    local steps = 3
    local stepSizeX = x / steps
    local stepSizeY = y / steps
    local sleepTime = 1

    for i = 1, steps do
        MoveMouseRelative(stepSizeX, stepSizeY)
        Sleep(math.max(1, math.floor(sleepTime * smoothness)))
    end
end

local function startMouseMovement()
    PressMouseButton(1)
    movementIndex = 1

    while isMouseButtonPressed and IsKeyLockOn("capslock") do
        local movement = movementPattern[movementIndex]
        if not movement then
            movementIndex = 1
            movement = movementPattern[movementIndex]
        end

        local moveX = movement[1] * movementModifier
        local moveY = movement[2] * movementModifier
        performSmoothMouseMovement(moveX, moveY, movementSmoothness)

        Sleep(99)

        if not IsMouseButtonPressed(1) then
            break
        end

        movementIndex = movementIndex + 1
        if movementIndex > #movementPattern then
            movementIndex = 1
        end
    end

    Sleep(80)
    ReleaseMouseButton(1)
    Sleep(80)
    movementIndex = 1
    
end

function OnEvent(event, arg)
    if event == "PROFILE_ACTIVATED" then
        EnablePrimaryMouseButtonEvents(true)
        
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 1 then
        if IsKeyLockOn("capslock") then
            isMouseButtonPressed = true
            
            startMouseMovement()
        else
            
        end
    end

    if event == "MOUSE_BUTTON_RELEASED" and arg == 1 then
        if isMouseButtonPressed then
            isMouseButtonPressed = false
            
            movementIndex = 1
        end
    end
end

--[[ This script is developed by Tris The Kitten and you can request feature updates or report bugs on the GitHub page:
I will be updating the script with new features and improvements. Thank you for using the script! --]]
