-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Created by: Gillian Gonzales
-- Created on: May 07 2018
-- 
-- This file animates a charact using a spritesheet
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)
 
centerX = display.contentWidth * .5
centerY = display.contentHeight * .5


local dPad = display.newImage( "./assets/sprites/d-pad.png" )
dPad.x = 150
dPad.y = display.contentHeight - 200
dPad.alpha = 0.50
dPad.id = "d-pad"

local rightArrow = display.newImage( "./assets/sprites/rightArrow.png" )
rightArrow.x = 260
rightArrow.y = display.contentHeight - 200
rightArrow.id = "right arrow"

local jumpButton = display.newImage( "./assets/sprites/jumpButton.png" )
jumpButton.x = display.contentWidth - 80
jumpButton.y = display.contentHeight - 80
jumpButton.id = "jump button"
jumpButton.alpha = 0.5



local sheetOptionsNinjaIdle =
{
    width = 232,
    height = 439,
    numFrames = 10
}
local sheetIdleNinja = graphics.newImageSheet( "./assets/spritesheets/ninjaIdle.png", sheetOptionsNinjaIdle )

local sheetOptionsNinjaRun =
{
    width = 363,
    height = 458,
    numFrames = 10
}

local sheetRunNinja = graphics.newImageSheet( "./assets/spritesheets/ninjaRun.png", sheetOptionsNinjaRun )

local sheetOptionsRobotIdle =
{
    width = 567,
    height = 556,
    numFrames = 10
}

local sheetIdleRobot = graphics.newImageSheet( "./assets/spritesheets/robotIdle.png", sheetOptionsRobotIdle )

local sheetOptionsRobotJump =
{
    width = 567,
    height = 556,
    numFrames = 10
}

local sheetJumpRobot = graphics.newImageSheet( "./assets/spritesheets/robotJump.png", sheetOptionsRobotJump )

-- sequences table
local sequence_dataNinja = {
    -- consecutive frames sequence
    {
        name = "idle",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 0,
        sheet = sheetIdleNinja
    },
    {
     	name = "walk",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 1,
        sheet = sheetRunNinja
    }
}

local sequence_dataRobot = {
    -- consecutive frames sequence
    {
        name = "idle",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 0,
        sheet = sheetIdleRobot
    },
    {
     	name = "jump",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 1,
        sheet = sheetJumpRobot
    }
}


local ninja = display.newSprite( sheetIdleNinja, sequence_dataNinja )
ninja.x = centerX - 600
ninja.y = centerY

local Robot = display.newSprite( sheetIdleRobot, sequence_dataRobot )
Robot.x = centerX + 600
Robot.y = centerY

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character to the
        transition.moveBy( ninja, { 
            x = 150, 
            y = 0, 
            time = 500 
            } )
        ninja:setSequence( "walk" )
        ninja:play()
    end

    return true
end

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character to the
        transition.moveBy( Robot, { 
            x = 0, 
            y = -120, 
            time = 1000 
            } )
        Robot:setSequence( "jump" )
        Robot:play()
    end

    return true
end



-- After a short time, swap the sequence to 'seq2' which uses the second image sheet
local function resetToIdleNinja (event)
    if event.phase == "ended" then
        ninja:setSequence("idle")
        ninja:play()
    end
end

local function resetToIdleRobot (event)
    if event.phase == "ended" then
        Robot:setSequence("idle")
        Robot:play()
    end
end

rightArrow:addEventListener( "touch", rightArrow )
ninja:addEventListener("sprite", resetToIdleNinja)
jumpButton:addEventListener( "touch", jumpButton )
Robot:addEventListener("sprite", resetToIdleRobot)