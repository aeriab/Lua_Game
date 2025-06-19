-- main.lua

local GameConfig = require("conf")

local GAME_WIDTH = 1920  -- Your desired internal game resolution width
local GAME_HEIGHT = 1080 -- Your desired internal game resolution height

local gameCanvas -- The canvas where your game is drawn
local currentScale = 0.5 -- Current scaling factor for the canvas
local offsetX = 0      -- X offset for drawing the canvas (for centering)
local offsetY = 0      -- Y offset for drawing the canvas (for centering)


local myFont
local player = {}

function love.load()
    myFont = love.graphics.newFont("fonts/mine-sweeper.ttf", 100)

    player.x = GAME_WIDTH / 2 -- Center player initially
    player.y = GAME_HEIGHT / 2
    player.speed = 300
    player.sprite = love.graphics.newImage('sprites/aeria-logo.png')

    gameCanvas = love.graphics.newCanvas(GAME_WIDTH, GAME_HEIGHT)
    love.resize(love.graphics.getDimensions())
end

function love.update(dt)
    player.x = player.x + player.speed * dt * (int(love.keyboard.isDown("right")) - int(love.keyboard.isDown("left")))
    player.y = player.y + player.speed * dt * (int(love.keyboard.isDown("down")) - int(love.keyboard.isDown("up")))
end

function love.draw()
    love.graphics.setCanvas(gameCanvas)
    love.graphics.clear(0.2, 0.4, 0.6)

    love.graphics.draw(player.sprite, player.x - (player.sprite:getWidth() / 2), player.y - (player.sprite:getHeight() / 2))
    love.graphics.circle("fill",player.x,player.y,10)
    love.graphics.setFont(myFont)
    love.graphics.print("Game made \nin LOVE 2D!", 100, 100)



    love.graphics.setCanvas()
    love.graphics.clear(0, 0, 0)
    love.graphics.draw(gameCanvas, offsetX, offsetY, 0, currentScale, currentScale)
end



function love.resize(w, h)
    local screenWidth = w
    local screenHeight = h

    local scaleX = screenWidth / GAME_WIDTH
    local scaleY = screenHeight / GAME_HEIGHT

    currentScale = math.min(scaleX, scaleY)

    local scaledGameWidth = GAME_WIDTH * currentScale
    local scaledGameHeight = GAME_HEIGHT * currentScale

    offsetX = (screenWidth - scaledGameWidth) / 2
    offsetY = (screenHeight - scaledGameHeight) / 2
end








function love.keypressed(key, unicode)

    -- Toggle fullscreen with F11
    if key == "f11" then
        local isFullscreen = love.window.getFullscreen()
        local desktopWidth, desktopHeight = love.window.getDesktopDimensions()

        if isFullscreen then
            -- Exit fullscreen: set back to initial window size (from conf.lua)
            -- We can get initial values from love.window.getMode()
            local originalWidth, originalHeight, flags = love.window.getMode()
            love.window.setMode(originalWidth, originalHeight, {
                fullscreen = false,
                resizable = true,
                minwidth = love.window.getMinDimensions()
            })
        else
            -- Enter fullscreen: use desktop dimensions for "desktop fullscreen"
            love.window.setMode(desktopWidth, desktopHeight, {
                fullscreen = true,
                fullscreentype = "desktop", -- Use desktop resolution
                resizable = true            -- Still allow resizing in windowed if toggled back
            })
        end
    end


	if (key == "f8" or key == "escape") then
		love.event.quit()
	end
end








function int(value)
    return value and 1 or 0
end